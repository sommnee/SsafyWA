<template>
  <v-container v-if="place" class="place-detail test" fluid>
    <v-row align="center" class="content-row test">
      <v-col cols="6" class="left-col d-flex align-center justify-center">
        <div>
          <h2 class="placeFullName">{{ place.placeName }}</h2>
          <br />
          <p class="placeFullAddress">{{ place.roadAddressName }}</p>
          <br />
        </div>
      </v-col>
      <v-col cols="6" class="right-col d-flex align-center justify-center">
        <div>
          <p class="placeInfo">
            <strong>카테고리: </strong> {{ place.categoryGroupName }}<br />
            <strong>전화번호: </strong> {{ place.phone }}<br />
            <strong>웹 사이트: </strong>
            <a :href="place.placeUrl" class="website-link">{{ place.placeUrl }}</a>
          </p>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: "PlaceDetail",
  props: {
    place: {
      type: Object,
      required: true,
    },
  },
  created() {
    console.log("Place received in PlaceDetail.vue:", this.place);
  },
};
</script>

<style scoped>
@import "@/assets/fonts.css";
.place-detail {
  font-family: Inter-Regular;
  background-color: #f5f5f5;
  padding: 16px;
  margin: 0;
  border: 1px solid #ddd;
  border-radius: 0; /* Remove border-radius */
  width: 100vw; /* Full viewport width */
  height: 220px; /* Increase the height to make the box taller */
  box-sizing: border-box; /* Ensure padding and border are included in the width */
}
.content-row {
  height: 100%;
}
.left-col {
  font-family: Inter-Regular;
  padding-left: 30px; /* Adjust padding */
  padding-right: 10px; /* Adjust padding */
  text-align: left; /* Align text to the left */
}
.right-col {
  font-family: Inter-Regular;
  padding-right: 100px; /* Adjust padding */
  text-align: left; /* Align text to the left */
}
.placeFullName {
  font-family: Inter-Regular;
  font-size: 26px; /* Increase the font size for place name */
  font-weight: bold;
  text-align: left; /* Align text to the left */
  margin-top: 20px;
}
.placeFullAddress {
  font-family: Inter-Regular;
  font-size: 16px; /* Increase the font size for address */
  font-weight: normal;
  text-align: left; /* Align text to the left */
  margin: 0; /* Ensure no margin around the text */
  color: gray; /* Change font color to gray */
}
.placeInfo {
  font-family: Inter-Regular;
  font-size: 16px; /* Increase the font size for other text */
  font-weight: normal;
  text-align: left; /* Align text to the left */
  margin: 0; /* Ensure no margin around the text */
}
.website-link {
  color: #87ceeb !important; /* Normal link color */
}
.website-link:visited {
  color: #58d8ff !important; /* Link color after being clicked */
}
.test {
  /* background-color: tomato; */
}
</style>
