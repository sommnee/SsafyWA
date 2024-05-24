<script setup>
import { defineProps } from 'vue';
  const props = defineProps({
  article: {
    type: Object,
    required: true,
  },
});
</script>

<template>
    <v-container>
      <v-card class="post-card" outlined color="#F3F5F6">
        <v-row no-gutters align="center">
          <v-col class="post-header" cols="12" md="3">
            <v-avatar>
              <v-icon icon="mdi-account-circle"></v-icon>
            </v-avatar>
            <div class="author-info">
              <span class="author">{{ article.writer }}</span> | <span class="date">{{ article.writeDate }}</span>
            </div>
          </v-col>
          <v-divider vertical :thickness="5"></v-divider>
          <v-col class="post-content" cols="12" md="9">
            <div class="post-text">
              {{ article.content }}
            </div>
          </v-col>
        </v-row>
      </v-card>
    </v-container>
  </template>
  
  <style scoped>
  .post-card {
    padding: 16px;
    margin-bottom: 16px;
    transition: box-shadow 0.3s, transform 0.3s;
    cursor: pointer;
  }
  
  .post-card:hover {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    transform: translateY(-5px);
  }
  
  .post-header {
    display: flex;
    align-items: center;
  }
  
  .author-info {
    display: flex;
    align-items: center;
    font-size: 0.9rem;
    color: #14B5E6
  }
  
  .post-title {
    font-size: 1.2rem;
    margin-bottom: 8px;
  }
  
  .post-text {
    font-size: 1rem;
    margin-bottom: 8px;
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
  </style>
  