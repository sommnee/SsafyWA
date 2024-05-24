<template>
  <v-container class="review-preview" fluid>
    <v-row align="center" style="margin-left: 20px">
      <v-col cols="auto">
        <span class="review-total">리뷰 {{ totalReviews }}건</span>
      </v-col>
      <v-col cols="auto">
        <v-btn :color="buttonColor" class="ml-2" @click="dialog = true" style="color: aliceblue">
          리뷰 작성
        </v-btn>
      </v-col>
      <v-col cols="auto">
        <v-btn
          :color="buttonColor"
          class="more-reviews"
          @click="goToAllReviews"
          style="color: aliceblue"
        >
          리뷰 더 보기
        </v-btn>
      </v-col>
    </v-row>
    <v-row no-gutters>
      <v-col cols="12">
        <v-slide-group show-arrows>
          <template v-if="totalReviews > 0">
            <v-slide-item v-for="(review, index) in reviews" :key="index">
              <v-card class="review-card" height="200px">
                <v-row no-gutters>
                  <v-col cols="4">
                    <v-img :src="review.imageUrl" class="review-image"></v-img>
                  </v-col>
                  <v-col cols="8" class="review-text">
                    <v-card-title class="review-title">{{ review.title }}</v-card-title>
                    <v-card-subtitle class="review-id">{{ review.writer }}</v-card-subtitle>
                    <v-card-subtitle class="review-content">{{
                      truncatedContent(review.content)
                    }}</v-card-subtitle>
                  </v-col>
                </v-row>
              </v-card>
            </v-slide-item>
          </template>
          <template v-else>
            <v-slide-item>
              <v-card class="review-card no-review-card" height="200px">
                <v-row no-gutters align="center" justify="center" class="text-center">
                  <v-col>
                    <v-card-title>방문 후 리뷰를 작성해주세요!!</v-card-title>
                  </v-col>
                </v-row>
              </v-card>
            </v-slide-item>
          </template>
        </v-slide-group>
      </v-col>
    </v-row>
    <v-dialog v-model="dialog" max-width="800px">
      <v-card>
        <v-card-text>
          <ReviewWrite
            :place-id="place.placeId"
            :user-info="userinfo"
            @review-added="handleReviewAdded"
            @dialog-close="dialog = false"
          />
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import ReviewWrite from "@/components/review/ReviewWrite.vue";
import { useMemberStore } from "@/stores/member";
import { storeToRefs } from "pinia";
import axios from "axios";
const extractTextThumbnail = (content) => {
  // DOMParser를 사용하여 HTML 파싱
  const parser = new DOMParser();
  const doc = parser.parseFromString(content, 'text/html');
  const textContent = doc.body.textContent || "";
  // 첫 100자 추출
  return textContent.length > 30 ? textContent.substring(0, 100) + '...' : textContent;
};
// Get userinfo from the store
const memberStore = useMemberStore();
const { userinfo } = storeToRefs(memberStore);

const props = defineProps({
  reviews: {
    type: Array,
    required: true,
  },
  totalReviews: {
    type: Number,
    required: true,
  },
  place: {
    type: Object,
    required: true,
  },
});

const dialog = ref(false);
const buttonColor = ref("#58d8ff");
const router = useRouter();

const handleReviewAdded = (review) => {
  props.reviews.push(review);
  props.totalReviews += 1;
  dialog.value = false;
};

const fetchReviews = async () => {
  try {
    const response = await axios.get(`http://localhost:8080/reviews/place/${props.place.placeId}`);
    props.reviews.splice(0, props.reviews.length, ...response.data);
    props.totalReviews = response.data.length;
  } catch (error) {
    console.error("Error fetching reviews:", error);
  }
};

onMounted(() => {
  fetchReviews();
});

const goToAllReviews = () => {
  router.push({
    name: "ReviewList",
    params: {
      placeId: props.place.placeId,
      placeName: props.place.placeName,
    },
  });
};

const truncatedContent = (content) => {
  return content.length > 10 ? content.substring(0, 20) + "..." : content;
};
</script>

<style scoped>
.review-preview {
  padding: 16px;
  width: 100%;
  height: auto;
  margin-top: 20px;
}
.review-image {
  height: 100%;
  width: 100%;
  object-fit: cover;
  border-radius: 10px;
}
.review-total {
  margin-left: 50px;
  font-size: 1.2rem;
}
.review-card {
  background-color: #f3f5f6;
  display: flex;
  align-items: center;
  width: 400px;
  height: 200px;
  margin: 30px;
  text-align: left;
  border-radius: 10px;
  overflow: hidden;
}
.no-review-card {
  background-color: #f3f5f6;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  color: #9e9e9e;
}
.review-title {
  font-size: 1rem;
  margin: 8px 16px 0 16px;
}
.review-id {
  font-size: 0.875rem;
  color: #14b5e6;
  margin: 0 16px 16px 16px;
}
.review-content {
  font-size: 0.875rem;
  margin: 0 16px 16px 16px;
}
.more-reviews {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  /* width: 200px; */
  text-align: center;
  background-color: #128fb5;
  color: white;
  /* border-radius: 10px; */
}
.more-reviews:hover {
  background-color: #128fb5;
}
</style>
