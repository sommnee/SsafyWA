<script setup>
import {ref} from "vue";
import { getLikedPost } from '@/api/profile';
import { useMemberStore } from '@/stores/member';
import { storeToRefs } from 'pinia';
import { onMounted } from 'vue';
import BoardListItem from "../board/BoardListItem.vue";
const memberStore = useMemberStore()
const {userinfo} = storeToRefs(memberStore);
const articles = ref([]);
const page = ref(1);
const extractTextThumbnail = (content) => {
  // DOMParser를 사용하여 HTML 파싱
  const parser = new DOMParser();
  const doc = parser.parseFromString(content, "text/html");
  const textContent = doc.body.textContent || "";
  // 첫 100자 추출
  return textContent.length > 30 ? textContent.substring(0, 100) + "..." : textContent;
};
const fetchArticle = () => {
    const userId = userinfo.value.userId;
    getLikedPost(
        userId,
        ({data}) => {
          articles.value = data.map((article) => {
            return {
              ...article,
              thumbnail: extractTextThumbnail(article.content),
            };
          });
        },
        (error) => {
            console.log(error);
        }
    )
}
onMounted(() => {
    fetchArticle();
})
</script>

<template>
    <div>
        <v-data-iterator :items="articles" :page="page">
          <template v-slot:default="{ items }">
            <template
              v-for="(item, i) in items"
              :key="i"
            >
              <BoardListItem :article="item.raw"/>
              <br>
            </template>
          </template>
        </v-data-iterator>
        <v-row justify="center">
          <v-col cols="8">
            <v-container class="max-width">
              <v-pagination
                v-model="page"
                :length="Math.ceil(articles.length / 5)"
                class="my-4"
              ></v-pagination>
            </v-container>
          </v-col>
        </v-row>
    </div>
</template>

<style scoped>

</style>