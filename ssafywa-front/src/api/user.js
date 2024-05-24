import { localAxios } from "@/util/http-commons";
const local = localAxios();

async function login(param, success, fail){
    await local.post(`/member/login`, param).then(success).catch(fail);
}
async function logout(userid, success, fail) {
    await local.get(`/member/logout`,{params: {userid: userid}}).then(success).catch(fail);
}
async function findById(userid, success, fail) {
    local.defaults.headers["Authorization"] = sessionStorage.getItem("accessToken");
    await local.get(`/member/${userid}`).then(success).catch(fail);
}
async function tokenRegeneration(user, success, fail) {
    local.defaults.headers["refreshToken"] = sessionStorage.getItem("refreshToken"); //axios header에 refresh-token 셋팅
    await local.post(`/member/refresh`, user).then(success).catch(fail);
}
async function getMemberList(param, success, fail) {
    await local.get(`/member/list`, {params : {currentUserId : param}}).then(success).catch(fail);
}
async function signUp(param, success, fail) {
    await local.post(`/member/regist`, param).then(success).catch(fail);
}
export {login, logout, findById, tokenRegeneration, getMemberList,signUp};