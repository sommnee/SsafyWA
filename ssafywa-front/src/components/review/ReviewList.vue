<template>
  <h2>{{ place }}</h2>
  <v-container>
    <v-row class="selectChoice">
      <v-col cols="12" md="4" class="d-flex align-center">
        <v-select
          v-model="selectedSort"
          :items="sortOptions"
          item-title="text"
          label="정렬 기준"
          item-value="value"
          placeholder="정렬 기준"
          class="custom-select"
          variant="solo-filled"
        ></v-select>
        <v-btn
          @click="fetchReviews"
          class="viewButton"
          style="height: 56px; background-color: #58d8ff; color: aliceblue"
        >
          조회
        </v-btn>
      </v-col>
    </v-row>
    <v-row class="searchNum">
      <v-col cols="12">
        <h3>{{ placeName }} 리뷰 {{ totalReviews }}개</h3>
      </v-col>
    </v-row>
    <v-row>
      <ReviewCard
        v-for="review in paginatedReviews"
        :key="review.id"
        :review="review"
        @like="handleLike"
      />
    </v-row>
    <v-row justify="center">
      <v-col cols="8">
        <v-container class="max-width">
          <v-pagination v-model="page" :length="pages" class="my-4"></v-pagination>
        </v-container>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import { ref, computed, watch, onMounted } from "vue";
import { useRoute } from "vue-router";
import axios from "axios";
import { storeToRefs } from "pinia";
import { useMemberStore } from "@/stores/member";
import ReviewCard from "@/components/review/ReviewCard.vue";

const props = defineProps({
  place: Object,
});

const route = useRoute();
const placeId = ref(route.params.placeId);
const placeName = ref(route.params.placeName);
const totalReviews = ref(0);
const selectedSort = ref("");
const sortOptions = [
  { text: "좋아요순", value: "likes" },
  { text: "등록순", value: "date" },
];
const reviews = ref([]);
const page = ref(1);
const itemsPerPage = 12;

const memberStore = useMemberStore();
const { userinfo, isLogin } = storeToRefs(memberStore);

const fetchReviews = () => {
  const sortOrder = selectedSort.value || "likes";
  axios
    .get(`http://localhost:8080/reviews/place/${placeId.value}/${sortOrder}`)
    .then((response) => {
      reviews.value = response.data;
    })
    .catch((error) => {
      console.error("Error fetching reviews:", error);
    });
};

const fetchTotalReviews = () => {
  axios
    .get(`http://localhost:8080/reviews/place/${placeId.value}`)
    .then((response) => {
      totalReviews.value = response.data.length;
    })
    .catch((error) => {
      console.error("Error fetching total reviews:", error);
    });
};

const handleLike = (reviewId) => {
  if (!isLogin.value) {
    alert("로그인 후 이용하세요");
    return;
  }

  const review = reviews.value.find((r) => r.id === reviewId);
  if (review) {
    review.likes = toggleLike(reviewId, review.likes);
  }
};

const toggleLike = (reviewId, currentLikes) => {
  const action = currentLikes > 0 ? "unlike" : "like";
  axios
    .post(`http://localhost:8080/reviews/${reviewId}/${action}`, { userId: userinfo.value.userId })
    .then(() => {
      currentLikes = action === "like" ? currentLikes + 1 : currentLikes - 1;
    })
    .catch((error) => {
      console.error(`Error ${action} review:`, error);
    });
  return currentLikes;
};

onMounted(() => {
  fetchReviews();
  fetchTotalReviews();
});

watch(route, () => {
  fetchReviews();
  fetchTotalReviews();
});

const pages = computed(() => {
  return Math.ceil(reviews.value.length / itemsPerPage);
});

const paginatedReviews = computed(() => {
  const start = (page.value - 1) * itemsPerPage;
  const end = page.value * itemsPerPage;
  return reviews.value.slice(start, end);
});
</script>

<style scoped>
@import "@/assets/fonts.css";

.selectChoice {
  margin: 50px 0px 0px -20px;
  display: flex;
  align-items: center;
}

.searchNum {
  margin-top: 15px;
  margin-bottom: 25px;
}

.custom-select {
  font-family: Inter-Regular;
  flex-grow: 1;
}

.v-btn {
  min-width: 0;
}

.viewButton {
  margin-left: 20px;
  margin-bottom: 20px;
  height: 56px;
  line-height: 56px;
}
</style>
