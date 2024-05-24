<script setup>
import { ref, onMounted, watch } from "vue";
import BoardListItem from "../components/board/BoardListItem.vue";

const page = ref(1);

import { getCategoryList, getSortedList, listArticle } from "@/api/board";
import { useRouter } from "vue-router";
import { useMemberStore } from "@/stores/member";
import { storeToRefs } from "pinia";
const router = useRouter();
const articles = ref([]);
const category = ref();
const memberStore = useMemberStore();
const {userinfo} = storeToRefs(memberStore);
const extractTextThumbnail = (content) => {
  // DOMParser를 사용하여 HTML 파싱
  const parser = new DOMParser();
  const doc = parser.parseFromString(content, "text/html");
  const textContent = doc.body.textContent || "";
  // 첫 100자 추출
  return textContent.length > 30 ? textContent.substring(0, 100) + "..." : textContent;
};
const categoryOptions = [
  { text: "자유 게시판", value: 1 },
  { text: "우리 게시판", value: 2 },
  { text: "거래 게시판", value: 3 },
  { text: "질문 게시판", value: 4 },
  { text: "정보 게시판", value: 5 },
];

const getArticleList = () => {
  listArticle(
    ({ data }) => {
      articles.value = data.map((article) => {
        return {
          ...article,
          thumbnail: extractTextThumbnail(article.content),
        };
      });
      console.log(articles.value);
    },
    (error) => {
      console.error(error);
    }
  );
};
watch(
  () => category.value,
  () => {
    getCategory();
  }
);
onMounted(() => {
  getArticleList();
});
const goWrite = () => {
  router.push("/board/write");
};
const getCategory = () => {
  getCategoryList(
    category.value,
    userinfo.value.campus,
    ({ data }) => {
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
  );
};
const clickLikeSort = () => {
  getSortedList(
    category.value,
    "like",
    ({ data }) => {
      articles.value = data.map((article) => {
        return {
          ...article,
          thumbnail: extractTextThumbnail(article.content),
        };
      });
    },
    (error) => {
      console.log("clickLikeSort error", error);
    }
  );
};
const clickReadCountSort = () => {
  getSortedList(
    category.value,
    "read",
    ({ data }) => {
      articles.value = data.map((article) => {
        return {
          ...article,
          thumbnail: extractTextThumbnail(article.content),
        };
      });
    },
    (error) => {
      console.log("clickLikeSort error", error);
    }
  );
};
const clickCommentCountSort = () => {
  getSortedList(
    category.value,
    "comment",
    ({ data }) => {
      articles.value = data.map((article) => {
        return {
          ...article,
          thumbnail: extractTextThumbnail(article.content),
        };
      });
    },
    (error) => {
      console.log("clickLikeSort error", error);
    }
  );
};
</script>

<template>
  <div style="margin-top: 7%">
    <v-row justify="center" align="center">
      <v-col cols="3">
        <v-select
          label="카테고리"
          v-model="category"
          :items="categoryOptions"
          item-title="text"
          item-value="value"
          variant="underlined"
          style="margin-left: 10%"
        ></v-select>
      </v-col>
      <v-col cols="6">
        <v-btn-toggle rounded="md" color="#F3F5F6">
          <v-btn @click="clickLikeSort">좋아요순</v-btn>
          <v-btn @click="clickReadCountSort">조회수순</v-btn>
          <v-btn @click="clickCommentCountSort">댓글순</v-btn>
        </v-btn-toggle>
      </v-col>
      <v-col cols="1">
        <v-btn
          style="
            width: 110px;
            height: 45px;
            background-color: #58d8ff;
            color: aliceblue;
            border-radius: 10px;
            margin-left: -50px;
          "
          class="writebtn"
          @click="goWrite"
          >글쓰기</v-btn
        >
      </v-col>
    </v-row>

    <v-data-iterator :items="articles" :page="page">
      <template v-slot:default="{ items }">
        <template v-for="(item, i) in items" :key="i">
          <BoardListItem :article="item.raw" />
          <br />
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

<style scoped></style>
