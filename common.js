
/////////填写你的apikey

const APIKEY = 'YOUR APIKEY';
const APISERET = 'YOUR APISERET';

//////////////////

//界面跳转
function navigateTo(page) {
    window.location.href = page + '.html';
}

//判断是否是手机
function isMobile() {
    const userAgentInfo = navigator.userAgent;
    const mobileAgents = ['Android', 'iPhone', 'SymbianOS', 'Windows Phone', 'iPod']; // iPad
    let mobile_flag = false;
    // 根据userAgent判断是否是手机
    for (let v = 0; v < mobileAgents.length; v++) {
        if (userAgentInfo.indexOf(mobileAgents[v]) > 0) {
            mobile_flag = true;
            break;
        }
    }

    const screen_width = window.screen.width;
    const screen_height = window.screen.height;

    // 根据屏幕分辨率判断是否是手机
    if (screen_width < 500 && screen_height < 800) {
        mobile_flag = true;
    }
    return mobile_flag;
}

//设置界面大小
function resetContainer() {
    const screenH = document.documentElement.clientHeight || document.body.clientHeight;
    const screenW = document.documentElement.clientWidth || document.body.clientWidth;

    const container = document.getElementsByClassName('container')[0];

    const isMb = isMobile();

    console.log(`isMobole ----` + isMb);

    if (isMb == false) {// pc or ipad
        container.style.width = "375px";
        container.style.height = '667px';
        container.style.top = ((screenH - 667) / 2) +  "px";
        console.log(container.style.top);
        container.backgroundColor = 'red';
    }
}