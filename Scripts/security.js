function rotateLeft(value, bits) {
    return (value << bits) | (value >>> (32 - bits));
}

function addUnsigned(x, y) {
    var x4 = x & 0x40000000;
    var y4 = y & 0x40000000;
    var x8 = x & 0x80000000;
    var y8 = y & 0x80000000;
    var result = (x & 0x3fffffff) + (y & 0x3fffffff);
    if (x4 & y4) return result ^ 0x80000000 ^ x8 ^ y8;
    if (x4 | y4) {
        if (result & 0x40000000) return result ^ 0xc0000000 ^ x8 ^ y8;
        return result ^ 0x40000000 ^ x8 ^ y8;
    }
    return result ^ x8 ^ y8;
}

function md5F(x, y, z) { return (x & y) | ((~x) & z); }
function md5G(x, y, z) { return (x & z) | (y & (~z)); }
function md5H(x, y, z) { return x ^ y ^ z; }
function md5I(x, y, z) { return y ^ (x | (~z)); }

function md5Step(func, a, b, c, d, x, s, ac) {
    a = addUnsigned(a, addUnsigned(addUnsigned(func(b, c, d), x), ac));
    return addUnsigned(rotateLeft(a, s), b);
}

function utf8Encode(text) {
    text = text.replace(/\r\n/g, "\n");
    var result = "";
    for (var n = 0; n < text.length; n++) {
        var c = text.charCodeAt(n);
        if (c < 128) {
            result += String.fromCharCode(c);
        } else if ((c > 127) && (c < 2048)) {
            result += String.fromCharCode((c >> 6) | 192);
            result += String.fromCharCode((c & 63) | 128);
        } else {
            result += String.fromCharCode((c >> 12) | 224);
            result += String.fromCharCode(((c >> 6) & 63) | 128);
            result += String.fromCharCode((c & 63) | 128);
        }
    }
    return result;
}

function convertToWordArray(text) {
    var messageLength = text.length;
    var wordCountTemp1 = messageLength + 8;
    var wordCountTemp2 = (wordCountTemp1 - (wordCountTemp1 % 64)) / 64;
    var wordCount = (wordCountTemp2 + 1) * 16;
    var words = new Array(wordCount - 1);
    var bytePosition = 0;
    var byteCount = 0;
    while (byteCount < messageLength) {
        var wordIndex = (byteCount - (byteCount % 4)) / 4;
        bytePosition = (byteCount % 4) * 8;
        words[wordIndex] = (words[wordIndex] | (text.charCodeAt(byteCount) << bytePosition));
        byteCount++;
    }
    var finalWordIndex = (byteCount - (byteCount % 4)) / 4;
    bytePosition = (byteCount % 4) * 8;
    words[finalWordIndex] = words[finalWordIndex] | (0x80 << bytePosition);
    words[wordCount - 2] = messageLength << 3;
    words[wordCount - 1] = messageLength >>> 29;
    return words;
}

function wordToHex(value) {
    var result = "";
    for (var count = 0; count <= 3; count++) {
        var byteValue = (value >>> (count * 8)) & 255;
        var temp = "0" + byteValue.toString(16);
        result += temp.substr(temp.length - 2, 2);
    }
    return result;
}

function md5(text) {
    var x = convertToWordArray(utf8Encode(text));
    var a = 0x67452301;
    var b = 0xefcdab89;
    var c = 0x98badcfe;
    var d = 0x10325476;
    for (var k = 0; k < x.length; k += 16) {
        var aa = a;
        var bb = b;
        var cc = c;
        var dd = d;
        a = md5Step(md5F, a, b, c, d, x[k + 0], 7, 0xd76aa478);
        d = md5Step(md5F, d, a, b, c, x[k + 1], 12, 0xe8c7b756);
        c = md5Step(md5F, c, d, a, b, x[k + 2], 17, 0x242070db);
        b = md5Step(md5F, b, c, d, a, x[k + 3], 22, 0xc1bdceee);
        a = md5Step(md5F, a, b, c, d, x[k + 4], 7, 0xf57c0faf);
        d = md5Step(md5F, d, a, b, c, x[k + 5], 12, 0x4787c62a);
        c = md5Step(md5F, c, d, a, b, x[k + 6], 17, 0xa8304613);
        b = md5Step(md5F, b, c, d, a, x[k + 7], 22, 0xfd469501);
        a = md5Step(md5F, a, b, c, d, x[k + 8], 7, 0x698098d8);
        d = md5Step(md5F, d, a, b, c, x[k + 9], 12, 0x8b44f7af);
        c = md5Step(md5F, c, d, a, b, x[k + 10], 17, 0xffff5bb1);
        b = md5Step(md5F, b, c, d, a, x[k + 11], 22, 0x895cd7be);
        a = md5Step(md5F, a, b, c, d, x[k + 12], 7, 0x6b901122);
        d = md5Step(md5F, d, a, b, c, x[k + 13], 12, 0xfd987193);
        c = md5Step(md5F, c, d, a, b, x[k + 14], 17, 0xa679438e);
        b = md5Step(md5F, b, c, d, a, x[k + 15], 22, 0x49b40821);
        a = md5Step(md5G, a, b, c, d, x[k + 1], 5, 0xf61e2562);
        d = md5Step(md5G, d, a, b, c, x[k + 6], 9, 0xc040b340);
        c = md5Step(md5G, c, d, a, b, x[k + 11], 14, 0x265e5a51);
        b = md5Step(md5G, b, c, d, a, x[k + 0], 20, 0xe9b6c7aa);
        a = md5Step(md5G, a, b, c, d, x[k + 5], 5, 0xd62f105d);
        d = md5Step(md5G, d, a, b, c, x[k + 10], 9, 0x2441453);
        c = md5Step(md5G, c, d, a, b, x[k + 15], 14, 0xd8a1e681);
        b = md5Step(md5G, b, c, d, a, x[k + 4], 20, 0xe7d3fbc8);
        a = md5Step(md5G, a, b, c, d, x[k + 9], 5, 0x21e1cde6);
        d = md5Step(md5G, d, a, b, c, x[k + 14], 9, 0xc33707d6);
        c = md5Step(md5G, c, d, a, b, x[k + 3], 14, 0xf4d50d87);
        b = md5Step(md5G, b, c, d, a, x[k + 8], 20, 0x455a14ed);
        a = md5Step(md5G, a, b, c, d, x[k + 13], 5, 0xa9e3e905);
        d = md5Step(md5G, d, a, b, c, x[k + 2], 9, 0xfcefa3f8);
        c = md5Step(md5G, c, d, a, b, x[k + 7], 14, 0x676f02d9);
        b = md5Step(md5G, b, c, d, a, x[k + 12], 20, 0x8d2a4c8a);
        a = md5Step(md5H, a, b, c, d, x[k + 5], 4, 0xfffa3942);
        d = md5Step(md5H, d, a, b, c, x[k + 8], 11, 0x8771f681);
        c = md5Step(md5H, c, d, a, b, x[k + 11], 16, 0x6d9d6122);
        b = md5Step(md5H, b, c, d, a, x[k + 14], 23, 0xfde5380c);
        a = md5Step(md5H, a, b, c, d, x[k + 1], 4, 0xa4beea44);
        d = md5Step(md5H, d, a, b, c, x[k + 4], 11, 0x4bdecfa9);
        c = md5Step(md5H, c, d, a, b, x[k + 7], 16, 0xf6bb4b60);
        b = md5Step(md5H, b, c, d, a, x[k + 10], 23, 0xbebfbc70);
        a = md5Step(md5H, a, b, c, d, x[k + 13], 4, 0x289b7ec6);
        d = md5Step(md5H, d, a, b, c, x[k + 0], 11, 0xeaa127fa);
        c = md5Step(md5H, c, d, a, b, x[k + 3], 16, 0xd4ef3085);
        b = md5Step(md5H, b, c, d, a, x[k + 6], 23, 0x4881d05);
        a = md5Step(md5H, a, b, c, d, x[k + 9], 4, 0xd9d4d039);
        d = md5Step(md5H, d, a, b, c, x[k + 12], 11, 0xe6db99e5);
        c = md5Step(md5H, c, d, a, b, x[k + 15], 16, 0x1fa27cf8);
        b = md5Step(md5H, b, c, d, a, x[k + 2], 23, 0xc4ac5665);
        a = md5Step(md5I, a, b, c, d, x[k + 0], 6, 0xf4292244);
        d = md5Step(md5I, d, a, b, c, x[k + 7], 10, 0x432aff97);
        c = md5Step(md5I, c, d, a, b, x[k + 14], 15, 0xab9423a7);
        b = md5Step(md5I, b, c, d, a, x[k + 5], 21, 0xfc93a039);
        a = md5Step(md5I, a, b, c, d, x[k + 12], 6, 0x655b59c3);
        d = md5Step(md5I, d, a, b, c, x[k + 3], 10, 0x8f0ccc92);
        c = md5Step(md5I, c, d, a, b, x[k + 10], 15, 0xffeff47d);
        b = md5Step(md5I, b, c, d, a, x[k + 1], 21, 0x85845dd1);
        a = md5Step(md5I, a, b, c, d, x[k + 8], 6, 0x6fa87e4f);
        d = md5Step(md5I, d, a, b, c, x[k + 15], 10, 0xfe2ce6e0);
        c = md5Step(md5I, c, d, a, b, x[k + 6], 15, 0xa3014314);
        b = md5Step(md5I, b, c, d, a, x[k + 13], 21, 0x4e0811a1);
        a = md5Step(md5I, a, b, c, d, x[k + 4], 6, 0xf7537e82);
        d = md5Step(md5I, d, a, b, c, x[k + 11], 10, 0xbd3af235);
        c = md5Step(md5I, c, d, a, b, x[k + 2], 15, 0x2ad7d2bb);
        b = md5Step(md5I, b, c, d, a, x[k + 9], 21, 0xeb86d391);
        a = addUnsigned(a, aa);
        b = addUnsigned(b, bb);
        c = addUnsigned(c, cc);
        d = addUnsigned(d, dd);
    }
    return (wordToHex(a) + wordToHex(b) + wordToHex(c) + wordToHex(d)).toLowerCase();
}

function submitLoginForm(form) {
    var pwd = form.password.value;
    if (pwd.length > 0) {
        form.password_hash.value = md5(pwd);
        form.password.value = "";
    }
    return true;
}

function submitRegisterForm(form) {
    var pwd = form.reg_password.value;
    if (pwd.length > 0) {
        form.reg_password_hash.value = md5(pwd);
        form.reg_password.value = "";
    }
    return true;
}

