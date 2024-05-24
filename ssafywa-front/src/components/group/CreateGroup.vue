<script setup>
import { ref } from "vue";
import axios from "axios";
import { useRouter } from "vue-router";
import { storeToRefs } from "pinia";
import { useMemberStore } from "@/stores/member";

const router = useRouter();
const memberStore = useMemberStore();
const { userinfo, isLogin } = storeToRefs(memberStore);

const category = ref("");
const title = ref("");
const content = ref("");
const region = ref("");
const mode = ref("");
const numberOfMembers = ref("");

const categories = ref(["스터디", "운동", "맛집", "공동구매", "친목", "etc"]);
const regions = ref(["서울", "대전", "광주", "구미", "부울경"]);
const modes = ref(["오프라인", "온라인"]);
const memberNumbers = ref(["2", "3", "4", "5", "6", "7", "8", "9", "10", "10+"]);

const createGroup = async () => {
  try {
    if (!isLogin.value) {
      alert("로그인 후 이용하세요");
      return;
    }
    const loggedInUserId = userinfo.value.userId;
    console.log("Logged In User ID:", loggedInUserId); // Log user ID
    const newGroup = {
      groupName: title.value,
      type: category.value,
      groupOwner: loggedInUserId,
      recruitMaxNumber: parseInt(numberOfMembers.value),
      region: region.value,
      isOnline: mode.value,
      isRecruiting: true,
      content: content.value,
    };
    console.log("New Group Data:", newGroup); // Log group data being sent to backend
    await axios.post("http://localhost:8080/group/create", newGroup);
    router.push("/groups");
  } catch (error) {
    console.error("Failed to create group:", error);
  }
};
</script>

<template>
  <v-container class="center-content">
    <v-form class="full-screen-form" @submit.prevent="createGroup">
      <v-row>
        <v-col cols="6">
          <v-select v-model="region" :items="regions" label="지역" required></v-select>
        </v-col>
        <v-col cols="6">
          <v-select v-model="category" :items="categories" label="그룹 종류" required></v-select>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="6">
          <v-select v-model="mode" :items="modes" label="모임 방식" required></v-select>
        </v-col>
        <v-col cols="6">
          <v-select
            v-model="numberOfMembers"
            :items="memberNumbers"
            label="모집 인원"
            required
          ></v-select>
        </v-col>
      </v-row>
      <v-text-field v-model="title" label="그룹명" required></v-text-field>
      <v-textarea
        v-model="content"
        label="모집하는 그룹에 대한 설명을 입력해주세요!"
        required
      ></v-textarea>
      <v-btn
        type="submit"
        class="centered-button"
        style="width: 90px; background-color: #58d8ff; color: aliceblue"
        >그룹 생성</v-btn
      >
    </v-form>
  </v-container>
</template>

<style scoped>
.center-content {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  flex-direction: column;
}
.full-screen-form {
  width: 80%;
  max-width: 600px;
}
.centered-button {
  display: block;
  margin: 20px auto;
  background-color: #58d8ff;
  color: white;
}
</style>
