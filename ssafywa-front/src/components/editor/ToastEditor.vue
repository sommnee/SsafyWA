<template>
  <div class="editor-container">
    <v-row class="control-row" align="end" justify="center">
      <v-col cols="6" class="select-col">
        <v-select
          v-model="selectedCategoryIndex"
          :items="items"
          variant="solo-filled"
          class="custom-select"
          placeholder="카테고리"
          style="height: 50px;"
        ></v-select>
      </v-col>
      <v-col cols="3"></v-col>
      <v-col cols="3" class="button-col">
        <v-btn class="button-item" rounded="lg" size="large" style="height: 50px;">뒤로 가기</v-btn>
        <v-btn class="button-item" rounded="lg" size="large" style="height: 50px; background-color: #58d8ff; color: aliceblue;" @click="savePost">게시하기</v-btn>
      </v-col>
    </v-row>
    <v-row cols="1" class="input-col">
      <v-col>
        <v-text-field v-model="title" label="" variant="solo-filled" placeholder="제목을 입력하시오"></v-text-field>
      </v-col>
    </v-row>
    
    <!-- 에디터를 적용할 요소 (컨테이너) -->
    <v-row class="editor-wrapper">
      <v-col cols="12"><div id="editor"></div></v-col>
    </v-row>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import { useRouter } from 'vue-router';
import '@toast-ui/editor/dist/toastui-editor.css';
import { Editor } from '@toast-ui/editor';
import {marked} from 'marked';
import { useMemberStore } from '@/stores/member';
import { storeToRefs } from 'pinia';
const items = ['자유 게시판', '우리 게시판', '거래 게시판', '질문 게시판', '정보 게시판'];
const title = ref('');
const selectedCategoryIndex = ref(null);
const memberStore = useMemberStore();
const {userinfo} = storeToRefs(memberStore);

const router = useRouter();
// const editorRef = ref(null);
const editorInstance = ref(null);
const globalUrl = 'http://localhost:8080';
// 선택된 카테고리 항목의 인덱스를 1부터 시작하는 값으로 변환
const category = computed(() => {
  const index = items.indexOf(selectedCategoryIndex.value);
  return index !== -1 ? index + 1 : null;
});

onMounted(() => {
  editorInstance.value = new Editor({
    el: document.querySelector('#editor'), // 에디터를 적용할 요소 (컨테이너)
    height: '700px', // 에디터 영역의 높이 값 (OOOpx || auto)
    initialEditType: 'markdown', // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
    initialValue: '', // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
    previewStyle: 'vertical', // 마크다운 프리뷰 스타일 (tab || vertical)
    placeholder: '내용을 입력해 주세요.',
    hooks: {
      async addImageBlobHook(blob, callback) {
        try {
          const formData = new FormData();
          formData.append('image', blob);

          const response = await fetch(globalUrl + '/image/upload', {
            method: 'POST',
            body: formData,
          });

          const filename = await response.text();
          console.log('서버에 저장된 파일명: ', filename);

          const imageUrl = `${globalUrl}/image/print?filename=${filename}`;
          callback(imageUrl, 'image alt attribute');
        } catch (error) {
          console.error('업로드 실패 : ', error);
        }
      },
    },
  });
});

const savePost = async () => {
  if (!editorInstance.value) {
    console.error('Editor instance is not available');
    return;
  }

  const contentMarkdown = editorInstance.value.getMarkdown();
  const contentHTML = marked(contentMarkdown);

  console.log('Markdown Content:', contentMarkdown);
  console.log('HTML Content:', contentHTML);

  if (contentMarkdown.length < 1) {
    alert('에디터 내용을 입력해 주세요.');
    throw new Error('editor content is required!');
  }

  const url = '/board/post';
  const params = {
    category: category.value,
    content: contentHTML,
    title: title.value,
    writer: userinfo.value.userId,
  };
  console.log(params)

  try {
    const response = await fetch(globalUrl + url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(params),
    });
    // 서버 응답 확인
    if (!response.ok) {
      throw new Error(`서버 응답 오류: ${response.statusText}`);
    }

    // 빈 응답 처리
    let responseData = null;
    const contentType = response.headers.get('content-type');
    if (contentType && contentType.includes('application/json')) {
      responseData = await response.json();
    }

    console.log(responseData);
    alert('게시글이 저장되었습니다.');
    router.push('/board/list');
  } catch (error) {
    console.error('저장 실패 : ', error);
  }
};
</script>

<style scoped>
.editor-container {
  margin-top: 7%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh; /* 화면 전체 높이 */
  gap: 0px;
}

.control-row {
  width: 100%;
  display: flex;
  align-items: end;
  justify-content: center;
  max-width: 1300px;
  /* background-color: black; */
}

.input-col {
  width: 100%;
  display: flex;
  align-items: end;
  justify-content: center;
  max-width: 1300px;
}

.select-col, .button-col {
  display: flex;
  align-items: center;
  justify-content: center;
}

.button-col {
  gap: 10px; /* 버튼 간의 간격 */
}

.button-item {
  margin-left: 10px;
}

.editor-wrapper {
  width: 100%;
  max-width: 1300px;
  margin: 0 auto;
}

.btn-div {
  display: flex;
  justify-content: center;
  gap: 10px; /* 버튼 간의 간격 */
  margin-top: 20px; /* 에디터와 하단 버튼 사이의 간격 */
}
</style>
