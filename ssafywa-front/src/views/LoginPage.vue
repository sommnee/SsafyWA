<template>
    <v-container class="login-container">
      <v-row justify="center">
        <v-col cols="12" sm="8" md="6">
          <v-card>
            <v-card-title class="headline">LOG IN</v-card-title>
            <v-card-text>
              <v-form ref="form" @submit.prevent="loginFunc" v-model="valid">
                <v-text-field
                  v-model="loginUser.userId"
                  class="input-container rounded-ts-pill"
                  :rules="[v => !!v || '아이디를 입력하세요.']"
                  label="ID"
                  required
                ></v-text-field>
                <v-text-field
                  v-model="loginUser.userPw"
                  :rules="[v => !!v || '비밀번호를 입력하세요.']"
                  label="Password"
                  type="password"
                  class="input-container rounded-ts-pill"
                  required
                ></v-text-field>
                <v-btn :disabled="!valid" type="submit" class="loginButton">
                  Log in
                </v-btn>
              </v-form>
            </v-card-text>
            <RouterLink class="link-text" :to="{name : 'regist'}">회원가입 / 비밀번호를 잊으셨나요?</RouterLink>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </template>
  
  <script setup>

import { useMemberStore } from '@/stores/member';
import { useMenuStore } from '@/stores/menu';
import { storeToRefs } from 'pinia';
import { ref } from 'vue';
import { RouterLink, useRoute, useRouter } from 'vue-router';

const memberStore = useMemberStore();
const route = useRoute()
// const menuStore = useMenuStore();
const {isLogin, isLoginError} = storeToRefs(memberStore);
const router = useRouter()
const {userLogin, getUserInfo} = memberStore;
  const valid = ref(false);
  const loginUser = ref({
    userId: "",
    userPw: "",
  })
const {changeMenuState} = useMenuStore();
  
  // function login() {
  //   if (valid.value) {
  //     alert(`Logging in with username: ${username.value} and password: ${password.value}`);
  //   }
  // }
  const loginFunc = async () => {
    await userLogin(loginUser.value)
    let token = sessionStorage.getItem("accessToken");
    console.log(token)
    console.log("isLogin : " + isLogin.value)
    if(isLoginError.value === true){
      alert('아이디 또는 비밀번호를 확인해주세요')
    }
    if(isLogin.value){
      getUserInfo(token)
      changeMenuState()
      const redirect = route.query.redirect || '/';
      router.push(redirect);
    }else{
      alert('아이디 또는 비밀번호를 확인해주세요')
    }
  }
  </script>
  <style scoped>
  @import '@/assets/fonts.css';
  
  .login-container {
    height: 100vh;
    width: 80%;
    padding: 60px;
    border-radius: 8px;
    text-align: center;
    margin: auto;
    display: flex;
    flex-direction: column;
    justify-content: center;
    font-family: Inter-Regular;
    margin-top: 100px;
  }
  
  .v-card {
    border: none;
    box-shadow: none;
  }
  
  .headline {
    margin: 20px;
    font-family: Inter-Bold;
  }
  
  .input-container {
    margin-bottom: 15px;
  }
  
  :v-deep .v-text-field .v-input__control .v-input__slot {
    background-color: #58d8ff; 
    border-radius: 100px;
  }
  
  :v-deep .v-text-field input {
    color: #333;
    border-radius: 15px; 
  }
  
  .loginButton {
    font-family: Inter-Regular;
    color: white;
    background-color: #58d8ff;
    margin-top: 0px;
    width: 100%;
    height: 40px;
    border-radius: 15px; /* Rounded corners for the button */
    transition: background-color 0.3s; /* Smooth transition for hover effect */
  }
  
  .loginButton:not(:disabled):hover {
    background-color: #008cff; /* Hover effect only applies when the button is not disabled */
  }
  
  .link-text {
    font-size: 12px;
    font-family: Inter-Regular;
    color: #58d8ff;
    margin-bottom: 10px;
  }
  </style>
  
  