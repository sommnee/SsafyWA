<template>
  <v-container style="margin-top: 2%">
    <v-row class="selectChoice">
      <v-col cols="12" md="3">
        <v-select
          v-model="selectedMode"
          :items="modes"
          placeholder="온오프라인"
          variant="solo-filled"
          class="custom-select"
          style="height: 50px"
        ></v-select>
      </v-col>
      <v-col cols="12" md="3">
        <v-select
          v-model="selectedRegion"
          :items="regions"
          placeholder="지역"
          variant="solo-filled"
          class="custom-select"
          style="height: 50px"
          @change="onRegionChange"
        ></v-select>
      </v-col>
      <v-col cols="12" md="3">
        <v-select
          v-model="selectedCategory"
          :items="categories"
          placeholder="카테고리"
          variant="solo-filled"
          class="custom-select"
          style="height: 50px"
          :disabled="!selectedRegion"
        ></v-select>
      </v-col>
      <v-col cols="1" md="1" class="d-flex align-center">
        <v-btn @click="fetchGroups" style="height: 50px; background-color: #58d8ff; color: white">
          조회
        </v-btn>
      </v-col>
      <v-col cols="2" md="2" class="d-flex align-center">
        <router-link to="/create-group">
          <v-btn style="height: 50px; background-color: #58d8ff; color: white; width: 100%">
            만들기
          </v-btn>
        </router-link>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12" v-for="(group, index) in paginatedGroups" :key="index">
        <GroupItem :group="group" @click="openGroupModal(group)" />
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="8">
        <v-container class="max-width">
          <v-pagination v-model="page" :length="pages" class="my-4"></v-pagination>
        </v-container>
      </v-col>
    </v-row>

    <v-dialog v-model="isModalOpen" persistent max-width="600px">
      <template v-slot:activator="{ on, attrs }"></template>
      <GroupDetail :group="selectedGroup" @close="isModalOpen = false" />
    </v-dialog>
  </v-container>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import axios from "axios";
import GroupItem from "@/components/group/GroupItem.vue";
import GroupDetail from "@/components/group/GroupDetail.vue"; // Import GroupDetail component
import { useMemberStore } from "@/stores/member";

const selectedRegion = ref(null);
const selectedCategory = ref(null);
const selectedMode = ref(null);
const regions = ref(["서울", "대전", "광주", "구미", "부울경"]);
const modes = ref(["온라인", "오프라인"]);
const categories = ref(["스터디", "운동", "맛집", "공동구매", "친목", "etc"]);
const groups = ref([]);
const page = ref(1);
const itemsPerPage = ref(12);

const memberStore = useMemberStore();
const { userinfo, isLogin } = memberStore;

const filteredGroups = computed(() => {
  return groups.value.filter((group) => {
    const isOnlineMatch =
      selectedMode.value === "온라인" ? group.isOnline === "온라인" : group.isOnline === "오프라인";
    return (
      (!selectedRegion.value || group.region === selectedRegion.value) &&
      (!selectedCategory.value || group.type === selectedCategory.value) &&
      (!selectedMode.value || isOnlineMatch)
    );
  });
});

const pages = computed(() => {
  return Math.ceil(filteredGroups.value.length / itemsPerPage.value);
});

const paginatedGroups = computed(() => {
  const start = (page.value - 1) * itemsPerPage.value;
  const end = page.value * itemsPerPage.value;
  return filteredGroups.value.slice(start, end);
});

const onRegionChange = () => {
  selectedCategory.value = null;
  page.value = 1;
};

const fetchGroups = async () => {
  try {
    let response;
    const params = {};

    if (selectedMode.value) {
      params.isOnline = selectedMode.value; // Directly use the selected mode value as string
    }
    if (selectedCategory.value) {
      params.type = selectedCategory.value;
    }
    if (selectedRegion.value) {
      params.region = selectedRegion.value;
    }

    console.log("Fetching groups with parameters:", params);

    if (Object.keys(params).length) {
      response = await axios.get("http://localhost:8080/group/api/groups", {
        params,
        headers: {
          Accept: "application/json",
        },
      });
    } else {
      response = await axios.get("http://localhost:8080/group/", {
        headers: {
          Accept: "application/json",
        },
      });
    }

    console.log("Response data:", response.data); // Log the response
    groups.value = Array.isArray(response.data) ? response.data : []; // Ensure groups is an array
  } catch (error) {
    console.error("Failed to fetch groups:", error);
    groups.value = []; // Reset groups to an empty array on error
  }
};

const handleLike = () => {
  // Implement the logic for handling likes
};

const selectedGroup = ref(null);
const isModalOpen = ref(false);

const openGroupModal = (group) => {
  selectedGroup.value = group;
  isModalOpen.value = true;
};

onMounted(() => {
  fetchGroups();
});
</script>

<style scoped>
@import "@/assets/fonts.css";

.selectChoice {
  margin: 50px 0px;
}

.searchNum {
  margin-top: 40px;
  margin-bottom: 20px;
}

.custom-select {
  font-family: Inter-Regular;
}

.v-btn {
  min-width: 0;
  border-radius: 8px; /* Make button rectangular */
}
</style>
