<script setup>
import { defineProps } from 'vue';
import { useRouter } from "vue-router";
const router = useRouter();
const props = defineProps({
  article: {
    type: Object,
    required: true,
  },
});
const goToArticle = () => {
  router.push(`/board/${props.article.id}`);
};
</script>

<template>
    <v-card 
      class="post-card" 
      outlined 
      color="#F3F5F6" 
      style="border-radius: 10px; margin: 0px 10% 0cap 10%;"
      @click="goToArticle"
      >
      <v-row align="center" no-gutters>
        <v-col class="post-title" cols="12" md="3">
          <strong>{{ article.title }}</strong>
        </v-col>
        <v-col cols="1" class="divider-col">
          <div class="divider"></div>
        </v-col>
        <v-col class="post-info" cols="12" md="8">
          <div class="post-details">
            <span class="author">{{ article.writer }}</span> | <span class="date">{{ article.writeDate }}</span>
          </div>
          <div class="post-content">
            {{ article.thumbnail }}
          </div>
          <div class="post-actions">
            <span class="likes"><v-icon color="red">mdi-heart</v-icon> {{ article.likeCount }}</span>
            <span class="comments"><v-icon color="blue">mdi-comment</v-icon> {{ article.commentCount }}</span>
            <span class="comments"><v-icon color="blue">mdi-eye</v-icon> {{ article.readCount }}</span>
          </div>
        </v-col>
      </v-row>
    </v-card>
  </template>
  <style scoped>
  .post-card {
    padding: 16px;
    margin-bottom: 16px;
  }
  .post-card:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* hover 시 그림자 효과 */
  transform: translateY(-5px); /* hover 시 살짝 위로 이동 */
  cursor: pointer; /* hover 시 커서 변경 */
  }

  .post-title {
    font-size: 1.2rem;
  }
  
  .post-info {
    padding-left: 16px;
  }
  
  .post-details {
    font-size: 0.9rem;
    color: #14B5E6
  }
  
  .post-content {
    font-size: 1rem;
    margin: 8px 0;
  }
  
  .post-actions {
    display: flex;
    align-items: center;
    gap: 16px;
    font-size: 0.9rem;
    color: gray;
  }
  
  .post-actions .likes, .post-actions .comments {
    display: flex;
    align-items: center;
    gap: 4px;
  }
  .divider-col {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
}

  .divider {
  height: 100%;
  width: 1px;
  margin: 0 16px;
  background-color: #000;
}
  </style>
  