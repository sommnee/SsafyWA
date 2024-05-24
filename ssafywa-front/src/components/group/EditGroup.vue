<template>
  <v-container v-if="group" class="d-flex justify-center align-center vcon">
    <v-card
      class="group-module"
      outlined
      rounded="lg"
      :style="{
        borderColor: '#58d8ff',
        borderWidth: '2px',
        borderRadius: '10px',
        width: '800px',
        height: 'auto',
      }"
    >
      <div class="inner-content">
        <v-form @submit.prevent="editGroup">
          <v-row>
            <v-col cols="6">
              <v-select v-model="region" :items="regions" label="지역" required></v-select>
            </v-col>
            <v-col cols="6">
              <v-select
                v-model="category"
                :items="categories"
                label="그룹 종류"
                required
              ></v-select>
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
          <div class="button-row">
            <v-btn
              type="submit"
              class="centered-button"
              style="width: 90px; background-color: #58d8ff; color: aliceblue"
              >수정 완료</v-btn
            >
            <v-btn
              @click="closeModal"
              class="centered-button"
              style="width: 90px; background-color: #f3f5f6; color: darkgray; margin-left: 10px"
              >닫기</v-btn
            >
          </div>
        </v-form>
      </div>
    </v-card>
  </v-container>
  <v-container v-else class="loading-container">
    <p>Loading...</p>
  </v-container>
</template>

<script setup>
import { ref, watch } from "vue";
import axios from "axios";
import { useRouter } from "vue-router";
import { useMemberStore } from "@/stores/member";
import { storeToRefs } from "pinia";

const props = defineProps({
  group: Object,
});

const emit = defineEmits(["close"]);

const router = useRouter();
const memberStore = useMemberStore();
const { userinfo, isLogin } = storeToRefs(memberStore);

const category = ref(props.group?.type || "");
const title = ref(props.group?.groupName || "");
const content = ref(props.group?.content || "");
const region = ref(props.group?.region || "");
const mode = ref(props.group?.isOnline || "오프라인");
const numberOfMembers = ref(props.group?.recruitMaxNumber.toString() || "");

const categories = ref(["스터디", "운동", "맛집", "공동구매", "친목", "etc"]);
const regions = ref(["서울", "대전", "광주", "구미", "부울경"]);
const modes = ref(["오프라인", "온라인"]);
const memberNumbers = ref(["2", "3", "4", "5", "6", "7", "8", "9", "10", "10+"]);

// Watch for changes in props.group and update the form fields accordingly
watch(
  () => props.group,
  (newGroup) => {
    if (newGroup) {
      category.value = newGroup.type;
      title.value = newGroup.groupName;
      content.value = newGroup.content;
      region.value = newGroup.region;
      mode.value = newGroup.isOnline;
      numberOfMembers.value = newGroup.recruitMaxNumber.toString();
    }
  },
  { immediate: true }
);

const editGroup = async () => {
  try {
    if (!isLogin.value) {
      alert("로그인 후 이용하세요");
      return;
    }
    const loggedInUserId = userinfo.value.userId;
    const updatedGroup = {
      groupId: props.group.id, // Ensure groupId is included
      groupName: title.value,
      type: category.value,
      region: region.value,
      isOnline: mode.value, // Send the string value as is
      recruitMaxNumber: parseInt(numberOfMembers.value),
      content: content.value,
    };

    console.log("Updated Group Data:", updatedGroup); // Debug log for the data being sent

    await axios.put(`http://localhost:8080/group/${props.group.id}`, updatedGroup, {
      params: { requesterId: loggedInUserId },
    });
    console.log("Group successfully updated");
    emit("close");
  } catch (error) {
    console.error("Failed to update group:", error.response ? error.response.data : error.message);
  }
};

const closeModal = () => {
  emit("close");
};
</script>

<style scoped>
.group-module {
  transition: transform 0.3s ease;
  width: 800px;
  max-height: 90vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  padding: 20px;
}

.inner-content {
  padding: 20px; /* Add padding inside the card for spacing */
  overflow-y: auto;
  max-height: calc(90vh - 40px); /* Adjust max-height to account for padding */
  width: 100%;
}

.group-module:hover {
  transform: scale(1.05);
}

.group-module::-webkit-scrollbar {
  display: none;
}

.group-module {
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none; /* Firefox */
}

.button-row {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  flex-direction: column;
}
</style>
