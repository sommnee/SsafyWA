<script setup>
import CommentComponent from '@/components/board/CommentComponent.vue';
import { ref, onMounted, watch, nextTick } from 'vue';
import { useRoute } from 'vue-router';
import { detailArticle, getCommentList, likePost, postComment, unlikePost, updateReadCount, userLikedPost } from '@/api/board'; // 게시글 상세 API 함수
import { storeToRefs } from 'pinia';
import { useMemberStore } from '@/stores/member';
const route = useRoute();
const article = ref({});
const page = ref(1);
const comment = ref([]);
const memberStore = useMemberStore();
const commentContent = ref('');
const {userinfo, isLogin} = storeToRefs(memberStore)
const isLiked = ref(false);
const fetchArticle = async () => {
  const { id } = route.params;
  detailArticle(
    id,
    ({data}) => {
      article.value = data
      console.log(article.value);
    },
    (error) => {
      console.error(error)
    }
  )
};
const checkIfLiked = async () => {
  try {
    const userId = userinfo.value.userId;
    userLikedPost(
      article.value.id, userId,
      ({data}) => {
        isLiked.value = data
      },
      (error) => {
        console.error(error)
      }
    );
  } catch (error) {
    console.error('Error checking if user liked the post:', error);
  }
};

const toggleLike = async () => {
  try {
    if(userinfo.value == null){
      alert('로그인 후 이용하세요')
    }
    const userId = userinfo.value.userId;
    if (isLiked.value) {
      unlikePost(article.value.id, userId,
        ({data}) => {
          article.value.likeCount--;
        },
        (error) => {
          console.error(error)
        }
      );
    } else {
      likePost(article.value.id, userId,
        ({data}) => {
          article.value.likeCount++;
        },
        (error) => {
          console.error(error)
        }
      );
    }
    isLiked.value = !isLiked.value;
    // 부모 컴포넌트에게 좋아요 상태가 변경되었음을 알림
  } catch (error) {
    console.error('Error toggling like:', error);
  }
};
// DOM 업데이트 후 img 태그에 스타일 적용
// const applyImageStyles = async () => {
//   await nextTick();
//   const images = document.querySelectorAll('.post-content img');
//   images.forEach((img) => {
//     img.style.width = '100px';
//     img.style.height = '100px';
//     img.style.objectFit = 'cover';
//   });
// };
// watch(article, async () => {
//   await applyImageStyles();
// })

watch(() => article.value.likeCount, () => {
  // 게시글의 좋아요 수가 변경될 때 컴포넌트를 다시 렌더링합니다.
  checkIfLiked();
  console.log(isLiked)
});
const updateRead = () => {
  const { id } = route.params;
  updateReadCount(
    id, 
    ({data}) => {
      console.log("조회수 증가 성공")
    },
    (error) => {
      console.error(error)
    }
  )
}
const fetchComment = async () => {
  const { id } = route.params;
  console.log(id)
  getCommentList(
    id,
    ({data})=> {
      comment.value = data
      console.log(data)
    },
    (error) =>{
      console.error(error)
    }
  )
}
const writeComment = async (requestData) => {
  postComment(
    requestData,
    ({response}) => {
      console.log("댓글 작성 성공!!");
      // if(response.status === httpStatusCode.OK){
      //   console.log("댓글 작성 성공!!");
      // }
      fetchComment()
    },
    (error) => {
      console.error(error)
    }
  )
}
const submitComment = () => {
  const userId = userinfo.value.userId;
  const { id } = route.params;
  const requestData = {
    boardId : id,
    writer : userId,
    content : commentContent.value
  }
  if(commentContent.value == ''){
    alert("댓글을 입력하시오")
  }else{
    writeComment(requestData);
    commentContent.value = "";
  }
}

onMounted(() => {
  fetchArticle();
  updateRead();
  checkIfLiked();
  fetchComment();
});
</script>

<template>
    <v-container style="margin-top: 7%;">
      <v-card class="post-card" outlined color="#F3F5F6">
        <v-row no-gutters>
          <v-col class="post-header" cols="12" md="12">
            <v-avatar>
              <v-icon icon="mdi-account-circle"></v-icon>
            </v-avatar>
            <div class="author-info">
              <span class="author">{{ article.writer }}</span> | <span class="date">{{ article.writeDate }}</span>
            </div>
          </v-col>
        </v-row>
        <v-row no-gutters>
          <v-col class="post-title" cols="12" md="12">
            <strong>{{ article.title }}</strong>
          </v-col>
        </v-row>
        <v-row no-gutters>
          <v-col class="post-content" cols="12" md="12" v-html="article.content"></v-col>
        </v-row>
      </v-card>
      <v-row no-gutters>
          <v-col class="post-actions" cols="12" md="12">
            <span class="likes" @click="toggleLike" style="background-color: #F3F5F6; padding: 10px; border-radius: 8px; cursor: pointer;">
              <v-icon :color="isLiked ? 'red' : 'grey'">mdi-heart</v-icon> {{ article.likeCount }}
            </span>
            <span class="comments" style="background-color: #F3F5F6; padding: 10px; border-radius: 8px;"><v-icon color="blue">mdi-comment</v-icon> {{ article.commentCount }}</span>
            <span class="comments" style="background-color: #F3F5F6; padding: 10px; border-radius: 8px;"><v-icon color="blue">mdi-eye</v-icon> {{ article.readCount }}</span>
          </v-col>
      </v-row>
      <v-row>
        <v-col>
          <v-textarea
            :model-value="value"
            v-model="commentContent"
            :rules="rules"
            label="댓글"
            counter
          ></v-textarea>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="10"></v-col>
        <v-col cols="1" style="margin-left: 7%; margin-top: -40px;">
          <v-btn  @click="submitComment" style="background-color: #58d8ff; color: aliceblue;">쓰기</v-btn>
        </v-col>
      </v-row>
      <v-data-iterator :items="comment" :page="page">
          <template v-slot:default="{ items }">
            <template
              v-for="(item, i) in items"
              :key="i"
            >
              <CommentComponent :article="item.raw" style="margin-bottom: -30px;"/>
            </template>
          </template>
        </v-data-iterator>
        <v-row justify="center">
        <v-col cols="8">
          <v-container class="max-width">
            <v-pagination
              v-model="page"
              :length="Math.ceil(comment.length / 5)"
              class="my-4"
            ></v-pagination>
          </v-container>
        </v-col>
      </v-row>
    </v-container>
  </template>
  
  <style scoped>
  .post-card {
    padding: 30px;
    margin-bottom: 16px;
    transition: box-shadow 0.3s, transform 0.3s;
    cursor: pointer;
  }
  
  .post-header {
    display: flex;
    align-items: center;
    margin-bottom: 8px;
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
  
  .post-content {
    font-size: 1rem;
    margin-bottom: 8px;
  }
  
  .post-image {
    width: 100%;
    max-height: 300px;
    object-fit: cover;
    margin-bottom: 8px;
  }
  
  .post-actions {
    display: flex;
    align-items: center;
    gap: 16px;
    font-size: 0.9rem;
    color: gray;
  }
  img { max-width: 350px; }
  
  .post-actions .likes, .post-actions .comments {
    display: flex;
    align-items: center;
    gap: 4px;
  }
  </style>
  <style >

  .post-content img {
      max-width: 1200px;
      max-height: 400px;
      display: block;
  }
  table, th, td{
    border: 1px;
  }

</style>