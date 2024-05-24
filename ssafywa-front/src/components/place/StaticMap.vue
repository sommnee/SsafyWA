<template>
  <div ref="staticMapContainer" class="static-map-container"></div>
</template>

<script setup>
import { ref, onMounted, watch, defineProps } from "vue";

const props = defineProps({
  x: {
    type: Number,
    required: true,
  },
  y: {
    type: Number,
    required: true,
  },
  markers: {
    type: Array,
    default: () => [],
  },
});

const staticMapContainer = ref(null);
let staticMap = null;

const createMap = () => {
  if (staticMapContainer.value) {
    const options = {
      center: new kakao.maps.LatLng(props.y, props.x),
      level: 3,
    };

    staticMap = new kakao.maps.StaticMap(staticMapContainer.value, options);

    // props.markers.forEach((marker) => {
    //   new kakao.maps.Marker({
    //     map: staticMap,
    //     position: new kakao.maps.LatLng(marker.y, marker.x),
    //   });
    // });
  }
};

onMounted(() => {
  createMap();
});

watch(
  () => [props.x, props.y, props.markers],
  () => {
    createMap();
  }
);
</script>

<style scoped>
.static-map-container {
  width: 100%;
  height: 300px;
}
</style>
