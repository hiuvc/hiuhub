(function () {
    'use strict';
    const isMobile = window.innerWidth < 600;

    function showNotice(msg, isError = false) {
        let old = document.getElementById('ug_notice');
        if (old) old.remove();
        const div = document.createElement('div');
        div.id = 'ug_notice';
        div.textContent = msg;
        div.style.position = 'fixed';
        div.style.bottom = '550px';
        div.style.left = '50%';
        div.style.transform = 'translateX(-50%)';
        div.style.background = isError ? '#d33' : '#2d2';
        div.style.color = '#fff';
        div.style.padding = '10px 20px';
        div.style.borderRadius = '8px';
        div.style.zIndex = '99999';
        document.body.appendChild(div);
        setTimeout(() => div.remove(), 4000);
    }

    function fixJsonInput(raw) {
        let parsed;
        try {
            parsed = JSON.parse(raw); // Thử parse trực tiếp
            return parsed;
        } catch {
            try {
                // Chỉ sửa 2 key quan trọng
                const keysToFix = ['_gcl_ls', 'UGPHONE-MQTT'];
                keysToFix.forEach(k => {
                    // Match giá trị dạng "{"..."}"
                    const regex = new RegExp(`"${k}"\\s*:\\s*"({[\\s\\S]*?})"`, 'g');
                    raw = raw.replace(regex, (_, inner) => {
                        const escaped = inner.replace(/\\/g, '\\\\').replace(/"/g, '\\"');
                        return `"${k}":"${escaped}"`;
                    });
                });

                parsed = JSON.parse(raw);

                // Chuyển giá trị chuỗi thành object thực
                keysToFix.forEach(k => {
                    if (parsed[k] && typeof parsed[k] === 'string') {
                        parsed[k] = JSON.parse(parsed[k]);
                    }
                });

                return parsed;
            } catch {
                throw new Error('JSON gốc không hợp lệ và không sửa được.');
            }
        }
    }



    // Wrapper GET
    function gmFetchJson(url, timeout = 10000) {
        return new Promise((resolve, reject) => {
            if (typeof GM_xmlhttpRequest === 'function') {
                GM_xmlhttpRequest({
                    method: 'GET',
                    url,
                    timeout,
                    onload(res) {
                        try {
                            const text = res.response || res.responseText;
                            const data = typeof text === 'object' ? text : JSON.parse(text);
                            resolve(data);
                        } catch (e) {
                            reject(e);
                        }
                    },
                    onerror: reject,
                    ontimeout() { reject(new Error('timeout')); }
                });
            } else {
                const proxy = 'https://api.allorigins.win/raw?url=';
                fetch(proxy + encodeURIComponent(url), { cache: 'no-store' })
                    .then(r => {
                        if (!r.ok) throw new Error('Proxy fetch failed: ' + r.status);
                        return r.json();
                    })
                    .then(resolve)
                    .catch(reject);
            }
        });
    }

    // Wrapper POST
    function gmPostJson(url, body, timeout = 15000) {
        return new Promise((resolve, reject) => {
            const payload = typeof body === 'string' ? body : JSON.stringify(body);
            if (typeof GM_xmlhttpRequest === 'function') {
                GM_xmlhttpRequest({
                    method: 'POST',
                    url,
                    data: payload,
                    headers: { 'Content-Type': 'application/json' },
                    timeout,
                    onload: resolve,
                    onerror: reject,
                    ontimeout() { reject(new Error('timeout')); }
                });
            } else {
                fetch(url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: payload,
                }).then(r => r.text()).then(text => resolve({ responseText: text })).catch(reject);
            }
        });
    }

    // Thêm CSS tùy chỉnh cho dropdown
    const style = document.createElement('style');
    style.textContent = `
    .transparent-select {
        background: transparent !important;
        backdrop-filter: none !important;
        border: 1px solid rgba(255,255,255,0.3) !important;
        color: white !important;
        border-radius: 6px !important;
        text-shadow: 1px 1px 2px rgba(0,0,0,0.8);
    }

    /* CSS mới cho các tùy chọn trong danh sách */
    .transparent-select option {
        background: rgba(0, 0, 0, 0.6) !important;
        color: white !important;
        backdrop-filter: blur(3px) !important;
        border: none !important;
    }

    .transparent-select:hover {
        background: rgba(255, 255, 255, 0.03) !important;
    }

    .transparent-select:focus {
        outline: none !important;
        border-color: rgba(255,255,255,0.3) !important;
        background: rgba(255, 255, 255, 0.03) !important;
    }
`;
    document.head.appendChild(style);

    // UI
    const toggleBtn = document.createElement('button');
    toggleBtn.textContent = '🧩 MENU';
    toggleBtn.style.position = 'fixed';
    toggleBtn.style.bottom = isMobile ? '100px' : '550px';
    toggleBtn.style.right = isMobile ? '10px' : '20px';
    toggleBtn.style.padding = isMobile ? '8px 12px' : '10px 15px';
    toggleBtn.style.borderRadius = '20px';
    toggleBtn.style.border = 'none';
    toggleBtn.style.background = '#007bff';
    toggleBtn.style.color = 'white';
    toggleBtn.style.cursor = 'pointer';
    toggleBtn.style.zIndex = '9999';
    document.body.appendChild(toggleBtn);

    const menu = document.createElement('div');
    menu.style.position = 'fixed';
    menu.style.top = isMobile ? '50px' : '60px';
    menu.style.right = isMobile ? '10px' : '20px';
    menu.style.zIndex = '9999';
    menu.style.border = '1px solid #ccc';
    menu.style.padding = '10px';
    menu.style.borderRadius = '10px';
    menu.style.boxShadow = '0 0 10px rgba(0,0,0,0.3)';
    menu.style.width = isMobile ? '90%' : '400px';
    menu.style.maxWidth = '95vw';
    menu.style.fontSize = isMobile ? '14px' : '16px';
    menu.style.display = 'none';
    document.body.appendChild(menu);

    // URL mặc định
    const DEFAULT_BG = "https://24hstore.vn/upload_images/images/hinh-nen-anime/hinh-nen-anime-ngau-nu-2.jpg"; // bạn đổi link mặc định ở đây

    function applyMenuBackground() {
        let url = GM_getValue("menuBackgroundURL", "");
        if (!url) url = DEFAULT_BG; // nếu chưa nhập thì dùng ảnh mặc định

        const testImg = new Image();
        testImg.onload = () => {
            menu.style.background = `url("${url}") no-repeat center center / cover`;
            menu.style.backgroundColor = "transparent";
            menu.style.backdropFilter = "none";
            menu.style.border = "1px solid rgba(255,255,255,0.2)";
        };
        testImg.onerror = () => {
            // fallback về mặc định nếu lỗi
            menu.style.background = `url("${DEFAULT_BG}") no-repeat center center / cover`;
            menu.style.backgroundColor = "transparent";
            menu.style.backdropFilter = "none";
            menu.style.border = "1px solid rgba(255,255,255,0.2)";
            showNotice("⚠️ Link ảnh lỗi, đã dùng nền mặc định");
        };
        testImg.src = url;
    }


    applyMenuBackground();

    toggleBtn.onclick = () => {
        menu.style.display = menu.style.display === 'none' ? 'block' : 'none';
        updateStockStatus();
    };

    const bgLabel = document.createElement('label');
    bgLabel.textContent = '🖼️ URL nền:';
    bgLabel.style.display = 'block';
    bgLabel.style.marginTop = '5px';
    bgLabel.style.color = 'white';
    bgLabel.style.textShadow = '1px 1px 2px rgba(0,0,0,0.8)';

    const bgInput = document.createElement('input');
    bgInput.type = 'text';
    bgInput.style.width = '100%';
    bgInput.style.marginTop = '3px';
    bgInput.placeholder = 'Dán link ảnh vào đây';
    bgInput.value = GM_getValue("menuBackgroundURL", "");

    const bgBtn = document.createElement('button');
    bgBtn.textContent = '💾 Lưu nền';
    bgBtn.style.marginTop = '5px';
    bgBtn.style.width = '100%';

    bgBtn.onclick = () => {
        GM_setValue("menuBackgroundURL", bgInput.value.trim());
        applyMenuBackground();
        showNotice("✅ Đã đổi nền UI!");
    };

    // Các nút còn lại
    const loginLabel = document.createElement('label');
    loginLabel.textContent = '📥 Nhập localStorage JSON Ở Đây...';
    loginLabel.style.display = 'block';
    loginLabel.style.marginTop = '10px';
    loginLabel.style.color = 'white';
    loginLabel.style.textShadow = '1px 1px 2px rgba(0,0,0,0.8)';

    const textarea = document.createElement('textarea');
    textarea.rows = 6;
    textarea.style.width = '100%';
    textarea.style.resize = 'vertical';
    textarea.style.fontSize = isMobile ? '13px' : '14px';
    textarea.value = GM_getValue('lastInput', '');

    const btnLogin = document.createElement('button');
    btnLogin.textContent = '🔐 Đăng nhập';
    btnLogin.style.marginTop = '10px';
    btnLogin.style.width = '100%';

    const btnClearJson = document.createElement('button');
    btnClearJson.textContent = '🧹 Xoá JSON';
    btnClearJson.style.marginTop = '5px';
    btnClearJson.style.width = '100%';

    const countryLabel = document.createElement('label');
    countryLabel.textContent = '🌐 Chọn Máy Chủ:';
    countryLabel.style.marginTop = '15px';
    countryLabel.style.display = 'block';
    countryLabel.style.color = 'white';
    countryLabel.style.textShadow = '1px 1px 2px rgba(0,0,0,0.8)';

    const selectCountry = document.createElement('select');
    selectCountry.className = 'transparent-select'; // Áp dụng class CSS
    selectCountry.style.width = '100%';
    selectCountry.style.padding = '6px';
    selectCountry.style.cursor = 'pointer';

    // thêm options
    ['hk', 'sg', 'de', 'us', 'jp'].forEach(c => {
        const opt = document.createElement('option');
        opt.value = c;
        opt.textContent = c.toUpperCase();
        selectCountry.appendChild(opt);
    });

    const stockStatus = document.createElement('div');
    stockStatus.style.marginTop = '5px';
    stockStatus.style.fontSize = '13px';
    stockStatus.style.color = 'white';
    stockStatus.style.textShadow = '1px 1px 2px rgba(0,0,0,0.8)';

    const btnBuy = document.createElement('button');
    btnBuy.textContent = '🛒 Tự động Mua Máy';
    btnBuy.style.marginTop = '10px';
    btnBuy.style.width = '100%';

    menu.appendChild(bgLabel);
    menu.appendChild(bgInput);
    menu.appendChild(bgBtn);
    menu.appendChild(loginLabel);
    menu.appendChild(textarea);
    menu.appendChild(btnLogin);
    menu.appendChild(btnClearJson);
    menu.appendChild(countryLabel);
    menu.appendChild(selectCountry);
    menu.appendChild(stockStatus);
    menu.appendChild(btnBuy);

    // Input, textarea trong suốt
    menu.querySelectorAll("input, textarea").forEach(el => {
        el.style.background = "transparent";
        el.style.backdropFilter = "none";
        el.style.border = "1px solid rgba(255,255,255,0.3)";
        el.style.color = "white";
        el.style.borderRadius = "6px";
        el.style.padding = "6px";

        // Placeholder color
        const placeholderStyle = `
            ::placeholder {
                color: rgba(255, 255, 255, 0.7) !important;
                opacity: 1;
            }
            :-ms-input-placeholder {
                color: rgba(255, 255, 255, 0.7) !important;
            }
            ::-ms-input-placeholder {
                color: rgba(255, 255, 255, 0.7) !important;
            }
        `;

        if (!document.getElementById('placeholder-style')) {
            const placeholderStyleEl = document.createElement('style');
            placeholderStyleEl.id = 'placeholder-style';
            placeholderStyleEl.textContent = placeholderStyle;
            document.head.appendChild(placeholderStyleEl);
        }
    });

    // Buttons trong suốt
    menu.querySelectorAll("button").forEach(btn => {
        btn.style.background = "transparent";
        btn.style.backdropFilter = "none";
        btn.style.border = "1px solid rgba(255,255,255,0.3)";
        btn.style.borderRadius = "6px";
        btn.style.color = "white";
        btn.style.cursor = "pointer";
        btn.style.transition = "all 0.2s ease";
        btn.style.padding = "8px";
        btn.style.textShadow = "1px 1px 2px rgba(0,0,0,0.8)";

        btn.onmouseover = () => {
            btn.style.background = "rgba(255, 255, 255, 0.1)";
            btn.style.borderColor = "rgba(255,255,255,0.5)";
        };
        btn.onmouseleave = () => {
            btn.style.background = "transparent";
            btn.style.borderColor = "rgba(255,255,255,0.3)";
        };
    });

    btnLogin.onclick = () => {
        try {
            const raw = textarea.value.trim();
            const parsed = fixJsonInput(raw);

            // Xoá key không cần thiết
            if (parsed.hasOwnProperty('userFloatInfo')) delete parsed.userFloatInfo;

            // Lưu vào localStorage
            localStorage.clear();
            for (const key in parsed) {
                const value = parsed[key];
                localStorage.setItem(key, typeof value === 'object' ? JSON.stringify(value) : value);
            }

            // Lưu lại textarea
            GM_setValue('lastInput', JSON.stringify(parsed));

            showNotice("✅ Đang Đăng Nhập...");
            setTimeout(() => location.reload(), 2000);
        } catch (e) {
            showNotice("❌ JSON không hợp lệ hoặc lỗi sửa: " + e.message, true);
        }
    };
    btnClearJson.onclick = () => {
        textarea.value = '';
        GM_setValue('lastInput', '');
        showNotice("🧹 Đã xoá JSON");
    };

    const countryNameMap = {
        'hk': 'Hong Kong',
        'sg': 'Singapore',
        'de': 'Germany',
        'us': 'USA',
        'jp': 'Japan'
    };

    async function updateStockStatus() {
        const url = 'https://dashboard.kingdev.sbs/tool_ug.php?status';
        stockStatus.textContent = '⏳ Đang kiểm tra stock...';
        try {
            const data = await gmFetchJson(url);
            if (!data || data.status !== 'success' || !data.servers) throw new Error('Dữ liệu không đúng');
            stockStatus.textContent = `Cập nhật: ${data.last_updated || 'không rõ'}`;
            let availableServer = null;
            for (const option of selectCountry.options) {
                const status = data.servers[countryNameMap[option.value]] || 'Unknown';
                option.textContent = `${option.value.toUpperCase()} (${status})`;
                if (!availableServer && status === 'Available') availableServer = option.value;
            }
            if (availableServer) {
                const curStatus = data.servers[countryNameMap[selectCountry.value]];
                if (curStatus !== 'Available') selectCountry.value = availableServer;
            }
            const selectedStatus = data.servers[countryNameMap[selectCountry.value]];
            btnBuy.disabled = selectedStatus !== 'Available';
            if (btnBuy.disabled) {
                btnBuy.style.background = 'rgba(153, 153, 153, 0.3)';
                btnBuy.style.borderColor = 'rgba(153, 153, 153, 0.5)';
                btnBuy.style.color = 'rgba(255, 255, 255, 0.5)';
            } else {
                btnBuy.style.background = 'transparent';
                btnBuy.style.borderColor = 'rgba(255,255,255,0.3)';
                btnBuy.style.color = 'white';
            }
        } catch (err) {
            console.error('updateStockStatus error', err);
            stockStatus.textContent = '❌ Lỗi lấy stock: ' + (err.message || err);
            btnBuy.disabled = true;
            btnBuy.style.background = 'rgba(153, 153, 153, 0.3)';
            btnBuy.style.borderColor = 'rgba(153, 153, 153, 0.5)';
            btnBuy.style.color = 'rgba(255, 255, 255, 0.5)';
        }
    }

    selectCountry.onchange = updateStockStatus;


    btnBuy.onclick = async () => {
        const raw = textarea.value.trim();
        const country = selectCountry.value;

        if (!raw) return showNotice("❌ Thiếu nội dung JSON!", true);
        if (btnBuy.disabled) return showNotice("❌ Server này hết hàng!", true);

        showNotice("⏳ Đang Mua Máy - Vui Lòng Đợi...");

        try {
            // Parse JSON, fix các key lồng nhau
            const parsed = fixJsonInput(raw);

            // Xoá key không cần thiết
            if (parsed.hasOwnProperty('userFloatInfo')) delete parsed.userFloatInfo;

            // Gửi POST mua máy
            const body = { content: JSON.stringify(parsed), country_code: country };
            await gmPostJson('https://tool.kingcrtis1.workers.dev/buy', body);

            // Lưu JSON vào localStorage để sử dụng lại
            localStorage.clear();
            for (const key in parsed) {
                const value = parsed[key];
                localStorage.setItem(key, typeof value === 'object' ? JSON.stringify(value) : value);
            }

            // Lưu lại textarea
            GM_setValue('lastInput', JSON.stringify(parsed));

            showNotice("✅ Đã mua máy!");
            setTimeout(() => location.reload(), 2000);

        } catch (err) {
            console.error('buy error', err);
            showNotice("❌ JSON không hợp lệ hoặc lỗi gửi: " + (err.message || err), true);
        }
    };


})();
