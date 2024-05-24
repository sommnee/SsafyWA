<script setup>
import { ref, onMounted } from "vue";
import { getHotPost } from '@/api/board';
import BoardListItem from "@/components/board/BoardListItem.vue";

const articles = ref([]);
const extractTextThumbnail = (content) => {
  // DOMParser를 사용하여 HTML 파싱
  const parser = new DOMParser();
  const doc = parser.parseFromString(content, 'text/html');
  const textContent = doc.body.textContent || "";
  // 첫 100자 추출
  return textContent.length > 30 ? textContent.substring(0, 100) + '...' : textContent;
};
const getArticleList = () => {
  getHotPost(
    ({ data }) => {
      console.log(data)
      articles.value = data.map(article => {
        return{
          ...article,
          thumbnail: extractTextThumbnail(article.content)
        }
      })
      console.log(articles.value);
    },
    (error) => {
      console.error(error);
    }
  )
}
onMounted(() => {
  getArticleList();
});
</script>

<template>
    <div style="margin-top: 7%; ">
        <h2 style="margin-bottom: 1%; margin-left: 10%;"><v-icon size="x-large" color="red">mdi-fire</v-icon><span style="color: red;">HOT</span> 게시글</h2>
        <v-data-iterator :items="articles">
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
    </div>
</template>

<style scoped>

</style>