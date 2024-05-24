<script setup>
import { signUp } from "@/api/user";
import { ref } from "vue";
import { useRouter } from "vue-router";

const username = ref("");
const nickname = ref("");
const password = ref("");
const confirmPassword = ref("");
const email = ref("");
const cities = ref(["서울", "대전", "부울경", "광주", "구미"]);
const campus = ref("");
const router = useRouter();

const passwordRules = [
  (v) => !!v || "회원가입을 위한 필수 입력 사항입니다.",
  (v) => v.length >= 8 || "8글자 이상 입력해주세요.",
  (v) => /[A-Z]/.test(v) || "대문자 하나 이상 입력해주세요.",
  (v) => /[a-z]/.test(v) || "소문자 하나 이상 입력해주세요.",
  (v) => /[0-9]/.test(v) || "숫자 하나 이상 입력해주세요.",
  (v) => /[\W_]+/.test(v) || "특수문자 하나 이상 입력해주세요.",
];

const confirmPasswordRules = [
  (v) => !!v || "비밀번호 확인해주세요.",
  (v) => v === password.value || "비밀번호가 일치하지 않습니다.",
];

function handleSubmit() {
  if (password.value !== confirmPassword.value) {
    alert("비밀번호가 일치하지 않습니다.");
    return;
  }
  const param = {
    userId: username.value,
    userName: username.value,
    nickName: nickname.value,
    userPassword: password.value,
    userEmail: email.value,
    campus: campus.value,
  };
  console.log(param)
  signUp(
    param,
    ({data}) => {
      alert(`Registration successful for username: ${username.value} ${data}`);
      router.push("/member/login")
    },
    (error) => {
      alert(`회원가입 실패: ${username.value} ${error}`);
    }
  )
}
</script>

<template>
  <div class="signup-container" style="margin-top: 5%;">
    <h2>회원가입</h2>
    <form @submit.prevent="handleSubmit">
      <div class="input-container">
        <v-text-field
          label="ID/아이디"
          v-model="username"
          variant="filled"
          required
          :rules="[(v) => !!v || '회원가입을 위한 필수 입력 사항입니다.']"
          placeholder="아이디를 입력하세요."
          class="input-field"
        ></v-text-field>
      </div>
      <div class="input-container">
        <v-text-field
          :class="some - style"
          label="닉네임"
          v-model="nickname"
          required
          :rules="[(v) => !!v || '회원가입을 위한 필수 입력 사항입니다.']"
          placeholder="닉네임을 입력하세요."
          class="input-field"
        ></v-text-field>
      </div>
      <div class="input-container">
        <v-text-field
          label="비밀번호 (8글자 이상, 대/소문자, 숫자, 특수 문자 필수)"
          v-model="password"
          type="password"
          required
          :rules="passwordRules"
          placeholder="비밀번호를 입력하세요."
          class="input-field"
        ></v-text-field>
      </div>
      <div class="input-container">
        <v-text-field
          label="비밀번호 확인"
          v-model="confirmPassword"
          type="password"
          required
          :rules="confirmPasswordRules"
          placeholder="비밀번호를 다시 입력하세요."
          class="input-field"
        ></v-text-field>
      </div>
      <div class="input-container">
        <v-text-field
          label="이메일"
          v-model="email"
          type="email"
          required
          :rules="[(v) => !!v || '회원가입을 위한 필수 입력 사항입니다.']"
          placeholder="이메일을 입력하세요."
          class="input-field"
        ></v-text-field>
      </div>
      <div class="input-container">
        <v-select
          label="캠퍼스 선택"
          v-model="campus"
          :items="cities"
          required
          placeholder="캠퍼스를 선택하세요."
          class="input-field"
        ></v-select>
      </div>
      <button type="submit">회원가입</button>
    </form>
  </div>
</template>

<style scoped>
h2 {
  margin: 30px;
}
.signup-container {
  width: 500px;
  padding: 20px;
  border-radius: 8px;
  text-align: center;
  margin: auto;
  display: flex;
  flex-direction: column;
}

.input-container {
  margin-bottom: 16px;
}

.input-field :deep(.v-input__control) {
  background-color: #fafafa;
  border-radius: 20px 0px;
  padding: 0;
}

.some-style :deep(.v-input__slot::before) {
  border-style: none !important;
}

.input-field :deep(.v-input__control::after) {
  border-bottom: none;
}

.input-field :deep(.v-select__selections) {
  background-color: #eeeef5;
  border-radius: 20px;
  padding: 0;
}

label {
  text-align: left;
  display: block;
  color: #495057;
}

button {
  width: 100%;
  height: 60px;
  padding: 12px;
  background-color: #58d8ff;
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  /* margin-top: 10px; */
}

button:hover {
  background-color: #0056b3;
}
</style>
