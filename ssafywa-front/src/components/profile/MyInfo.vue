<script setup>
import { ref, onMounted } from "vue";
import { useMemberStore } from '@/stores/member';
import { storeToRefs } from 'pinia';

const memberStore = useMemberStore();
const { userinfo, isLogin } = storeToRefs(memberStore);

const username = ref('');
const nickname = ref('');
const password = ref('');
const email = ref('');
const cities = ref(["서울", "대전", "부울경", "광주", "구미"]);
const campus = ref('');

onMounted(() => {
  username.value = userinfo.value.userId;
  nickname.value = userinfo.value.nickName;
  password.value = userinfo.value.userPassword;
  email.value = userinfo.value.userEmail;
  campus.value = userinfo.value.campus;
});
</script>

<template>
  <div class="signup-container">
    <form @submit.prevent="handleSubmit">
      <div class="input-container">
        <v-text-field
          label="ID/아이디"
          v-model="username"
          variant="filled"
          readonly
          class="input-field"
        ></v-text-field>
      </div>
      <div class="input-container">
        <v-text-field
          label="닉네임"
          v-model="nickname"
          readonly
          class="input-field"
        ></v-text-field>
      </div>
      <div class="input-container">
        <v-text-field
          v-model="password"
          type="password"
          label="비밀번호"
          readonly
          class="input-field"
        ></v-text-field>
      </div>
      <div class="input-container">
        <v-text-field
          label="이메일"
          v-model="email"
          type="email"
          readonly
          class="input-field"
        ></v-text-field>
      </div>
      <div class="input-container">
        <v-select
          label="캠퍼스 선택"
          v-model="campus"
          :items="cities"
          readonly
          class="input-field"
        ></v-select>
      </div>
    </form>
    <v-btn style="background-color: #58d8ff; color: aliceblue;">수정하기</v-btn>
  </div>
</template>

<style scoped>
.signup-container {
  padding: 20px;
}
.input-container {
  margin-bottom: 20px;
}
.input-field {
  width: 100%;
}
</style>
