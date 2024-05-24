import { localAxios } from "@/util/http-commons";
const local = localAxios();
function getAllGroups(success, fail){
    local.get(`/group/`).then(success).catch(fail);
}
export{
    getAllGroups
}
