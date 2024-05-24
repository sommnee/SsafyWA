import { ref } from "vue";
import { useRouter } from "vue-router";
import { defineStore } from "pinia";
import { jwtDecode } from "jwt-decode";

import { login, logout, findById, tokenRegeneration } from "@/api/user";
import { httpStatusCode } from "@/util/http-status";

export const useMemberStore = defineStore("memberStore", () => {
    const router = useRouter();
    const isLogin = ref(false);
    const isLoginError = ref(false)
    const userinfo = ref(null);
    const isValidToken = ref(false);

    const userLogin = async (loginUser) => {
        console.log(loginUser)
        await login(
            loginUser,
            (response) => {
                console.log(response.status,"!!!")
                console.log(response)
                if(response.status === httpStatusCode.CREATE){
                    console.log("로그인 성공!!");
                    let {data} = response
                    console.log(data)
                    let accessToken = data["accessToken"];
                    let refreshToken = data["refreshToken"];
                    console.log(accessToken)
                    isLogin.value = true;
                    isLoginError.value = false;
                    isValidToken.value = true
                    sessionStorage.setItem("accessToken", accessToken);
                    sessionStorage.setItem("refreshToken", refreshToken)
                }
            },
            (error) => {
                console.log("로그인 실패")
                isLogin.value = false;
                isLoginError.value = true;
                isValidToken.value = false;
                console.log(error)
            }
        )
    }
    const getUserInfo = async (token) => {
        let decodeToken = jwtDecode(token)
        console.log("decodeToken : " + decodeToken.userId)
        await findById(
            decodeToken.userId,
            (response) => {
                console.log(response)
                if(response.status === httpStatusCode.OK){
                    console.log("response : " + response.data.nickName)
                    userinfo.value = response.data
                    console.log(response.data)
                    console.log("userInfo : " + userinfo.value.nickName)
                }else{
                    console.log("유저 정보 없음!!!!")
                }
            }
        ),
        async (error) => {
            console.error(
              "g[토큰 만료되어 사용 불가능.] : ",
              error.response.status,
              error.response.statusText
            )
            isValidToken.value = false
    
            await tokenRegenerate()
          }
    }
    const tokenRegenerate = async () => {
        await tokenRegeneration(
            JSON.stringify(userinfo.value),
            (response) => {
                if(response.status === httpStatusCode.CREATE){
                    let accessToken = response.data["access-token"];
                    sessionStorage.setItem("accessToken", accessToken)
                    isValidToken.value = true
                }
            },
            async (error) => {
                if(error.response.status === httpStatusCode.UNAUTHORIZED){
                    await logout(
                        userinfo.value.userId,
                        (response) => {
                            if(response.status === httpStatusCode.OK){
                                console.log("리프레시 토큰 제거 성공")
                            }else{
                                console.log("리프레시 토큰 제거 실패")
                            }
                            alert('Refresh기반 토큰 제거 성공')
                            isLogin.value = false
                            userinfo.value = null
                            isValidToken.value = false
                            // router.push({name : })
                        },
                        (error) => {
                            console.log(error)
                            isLogin.value = false
                            userinfo.value = null
                        }
                    )
                }
            }
        )
    }
    const userLogout = async () => {
        console.log("로그아웃 아이디 : " + userinfo.value.userId);
        await logout(
            userinfo.value.userId,
            (response) => {
                if(response.status === httpStatusCode.OK){
                    isLogin.value = false
                    userinfo.value = null
                    isValidToken.value = false
                    sessionStorage.removeItem("accessToken")
                    sessionStorage.removeItem("refreshToken")
                }else{
                    console.log("유저 정보 없음")
                }
            },
            (error) => {
                console.log(error)
            }
        )
    }
    return {
        isLogin,
        isLoginError,
        userinfo,
        isValidToken,
        userLogin,
        getUserInfo,
        tokenRegenerate,
        userLogout
    }
})