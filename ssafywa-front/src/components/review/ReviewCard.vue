<template>
  <v-col cols="12" md="6" lg="4">
    <v-card class="mx-auto custom-card" @click="goToReviewDetail">
      <v-img :src="review.imageUrl" class="card-image" height="200px" cover></v-img>
      <v-card-title>{{ review.title }}</v-card-title>
      <v-card-subtitle>{{ review.writer }}</v-card-subtitle>
      <v-card-text>{{ review.content }}</v-card-text>
      <v-card-text class="review-date">{{ formattedDate }}</v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn icon @click.stop="toggleLike" class="heart-btn">
          <v-icon :color="isLiked ? 'blue' : 'black'">{{
            isLiked ? "mdi-heart" : "mdi-heart-outline"
          }}</v-icon>
          <span>{{ review.likes }}</span>
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-col>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { storeToRefs } from "pinia";
import { useMemberStore } from "@/stores/member";
import axios from "axios";

const props = defineProps({
  review: {
    type: Object,
    required: true,
  },
});

const memberStore = useMemberStore();
const { userinfo, isLogin } = storeToRefs(memberStore);

const isLiked = ref(false);

const checkIfLiked = async () => {
  if (!isLogin.value) return;

  try {
    const response = await axios.get(`http://localhost:8080/reviews/${props.review.id}/liked`, {
      params: { userId: userinfo.value.userId },
    });
    isLiked.value = response.data;
  } catch (error) {
    console.error("Error checking if user liked the review:", error);
  }
};

const toggleLike = async () => {
  if (!isLogin.value) {
    alert("로그인 후 이용하세요");
    return;
  }

  try {
    const action = isLiked.value ? "unlike" : "like";
    await axios.post(`http://localhost:8080/reviews/${props.review.id}/${action}`, null, {
      params: { userId: userinfo.value.userId },
    });
    props.review.likes += isLiked.value ? -1 : 1;
    isLiked.value = !isLiked.value;
  } catch (error) {
    console.error(`Error ${isLiked.value ? "unliking" : "liking"} review:`, error);
  }
};

onMounted(() => {
  checkIfLiked();
});
</script>

<style scoped>
.custom-card {
  margin-bottom: 20px;
  border-radius: 15px;
  overflow: hidden;
  cursor: pointer;
}
.card-image {
  border-top-left-radius: 15px;
  border-top-right-radius: 15px;
}
.heart-btn {
  margin-top: -10px;
}
.review-date {
  font-size: 0.75rem;
  color: grey;
  margin-top: 10px;
}
</style>
