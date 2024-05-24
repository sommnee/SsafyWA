<template>
  <v-container class="main-container no-border">
    <v-row justify="center">
      <v-col cols="12" md="10">
        <v-card class="no-border">
          <v-card-text>
            <v-row>
              <v-col>
                <v-text-field
                  label="리뷰 제목 입력해주세요!"
                  v-model="title"
                  outlined
                  class="no-border"
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-textarea
                  label="리뷰를 작성해주세요!"
                  v-model="content"
                  outlined
                  rows="10"
                  class="no-border"
                ></v-textarea>
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-file-input
                  label="파일 업로드"
                  v-model="file"
                  outlined
                  prepend-icon="mdi-paperclip"
                  class="no-border"
                ></v-file-input>
              </v-col>
            </v-row>
            <v-row justify="center">
              <v-col cols="auto">
                <v-btn class="write" color="#58d8ff" @click="handleSubmit">작성</v-btn>
              </v-col>
              <v-col cols="auto">
                <v-btn class="cancel" color="#F3F5F6" @click="handleCancel">취소</v-btn>
              </v-col>
            </v-row>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import { ref } from "vue";
import axios from "axios";

const props = defineProps({
  placeId: {
    type: Number,
    required: true,
  },
  userInfo: {
    type: Object,
    required: true,
  },
});

const emit = defineEmits(["review-added", "dialog-close"]);

const title = ref("");
const content = ref("");
const file = ref(null);

const handleSubmit = async () => {
  try {
    const imageUrl = file.value ? await uploadFile(file.value) : null;
    const review = {
      placeId: props.placeId,
      title: title.value,
      content: content.value,
      imageUrl: imageUrl,
      writer: props.userInfo.nickName,
    };
    await axios.post("http://localhost:8080/reviews", review);
    emit("review-added", review);
    handleCancel();
  } catch (error) {
    console.error("Error:", error);
  }
};

const uploadFile = async (file) => {
  const formData = new FormData();
  formData.append("file", file);

  const response = await axios.post("http://localhost:8080/s3/upload", formData, {
    headers: {
      "Content-Type": "multipart/form-data",
    },
  });

  return response.data; // Full URL of the uploaded file
};

const handleCancel = () => {
  title.value = "";
  content.value = "";
  file.value = null;
  emit("dialog-close");
};
</script>

<style scoped>
.review-image {
  max-width: 100%;
  height: auto;
  margin-top: 10px;
}
</style>
