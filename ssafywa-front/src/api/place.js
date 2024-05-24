import { localAxios } from "@/util/http-commons";
const local = localAxios();
function getLikedPlace(userId,success, fail){
    local.get(`/place/like/place/${userId}`).then(success).catch(fail);
}
export{
    getLikedPlace
}