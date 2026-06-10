// 顶部导航栏当前页面高亮
document.addEventListener('DOMContentLoaded', function () {
    var nav = document.querySelector('.nav');
    if (!nav) return;
    var page = location.pathname.split('/').pop().toLowerCase();
    var links = nav.querySelectorAll('a');
    for (var i = 0; i < links.length; i++) {
        var href = links[i].getAttribute('href');
        if (href && href.split('?')[0].toLowerCase() === page) {
            links[i].classList.add('active');
            break;
        }
    }
});

function startCarousel() {
    var box = document.getElementById("homeCarousel");
    if (!box) return;
    var slides = box.getElementsByClassName("carousel-slide");
    var dots = box.getElementsByClassName("carousel-dot");
    var index = 0;
    function showSlide(next) {
        for (var i = 0; i < slides.length; i++) {
            slides[i].className = "carousel-slide";
            if (dots[i]) dots[i].className = "carousel-dot";
        }
        index = next;
        slides[index].className = "carousel-slide active";
        if (dots[index]) dots[index].className = "carousel-dot active";
    }
    for (var j = 0; j < dots.length; j++) {
        dots[j].setAttribute("data-index", j);
        dots[j].onclick = function () {
            showSlide(parseInt(this.getAttribute("data-index"), 10));
        };
    }
    showSlide(0);
    window.setInterval(function () {
        var next = index + 1;
        if (next >= slides.length) next = 0;
        showSlide(next);
    }, 3500);
}

if (window.attachEvent) {
    window.attachEvent("onload", startCarousel);
} else {
    window.addEventListener("load", startCarousel, false);
}
