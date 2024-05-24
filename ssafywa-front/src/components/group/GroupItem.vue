<script setup>
import { defineProps, defineEmits } from "vue";
import { useRouter } from "vue-router";

const props = defineProps({
  group: {
    type: Object,
    required: true,
  },
});

const emits = defineEmits(["click"]);

const goToGroup = () => {
  emits("click");
};
</script>

<template>
  <v-card
    class="group-card"
    outlined
    color="#F3F5F6"
    height="110px"
    style="border-radius: 10px; margin: 0px 10% 0px 10%"
    @click="goToGroup"
  >
    <v-row align="center" no-gutters>
      <v-col
        class="group-name"
        cols="12"
        md="6"
        style="
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          text-align: center;
          margin-top: 10px;
        "
      >
        <strong>{{ group.groupName }}</strong>
        <div class="writer-details" style="margin-top: 10px">
          <span class="author">{{ group.groupOwner }}</span> |
          <span class="numOfGroup">{{ group.recruitMaxNumber }}</span>
        </div>
      </v-col>
      <v-col cols="1" class="divider-col">
        <div class="divider"></div>
      </v-col>
      <v-col
        class="group-info"
        cols="12"
        md="5"
        style="
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          text-align: center;
          margin-top: 10px;
        "
      >
        <div class="post-content" style="margin-top: 10px">
          <span class="group-type">{{ group.type }}</span> |
          <span class="region">{{ group.region }}</span> |
          <span class="isOnline">{{ group.isOnline }}</span>
        </div>
      </v-col>
    </v-row>
  </v-card>
</template>

<style scoped>
.group-card {
  padding: 16px;
  margin-bottom: 16px;
}
.group-card:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  transform: translateY(-5px);
  cursor: pointer;
}

.group-name {
  font-size: 1.2rem;
  text-align: center;
  margin-top: 10px;
}

.group-info {
  padding-left: 16px;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center; /* Center align items */
  margin-top: 10px; /* Add margin-top */
  margin-bottom: 5px;
}

.writer-details {
  font-size: 0.8rem;
  margin-top: 10px; /* Add margin-top */
}

.author {
  color: #58d8ff;
}

.divider-col {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
}

.divider {
  height: 100%;
  width: 1px;
  margin: 0 16px;
  background-color: #000;
}
</style>
