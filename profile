<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>To-do Học Tập</title>
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet" />
  <style>
    /* ==================== CSS VARIABLES ==================== */
    :root {
      --bg: #f0f4ff;
      --surface: #ffffff;
      --surface2: #f7f9ff;
      --border: #e2e8f8;
      --text-primary: #1a1f3c;
      --text-secondary: #6b748e;
      --accent: #4f6ef7;
      --accent-glow: rgba(79, 110, 247, 0.18);
      --accent2: #a78bfa;
      --done-color: #b0bcd4;
      --danger: #f87171;
      --shadow: 0 4px 24px rgba(79,110,247,0.10);
      --shadow-card: 0 2px 12px rgba(79,110,247,0.08);
      --radius: 18px;
      --radius-sm: 10px;
      --transition: 0.22s cubic-bezier(.4,0,.2,1);
    }

    /* DARK MODE */
    body.dark {
      --bg: #0f1224;
      --surface: #181d36;
      --surface2: #1e2445;
      --border: #2a3260;
      --text-primary: #e8eeff;
      --text-secondary: #7b87b8;
      --accent: #6b8cff;
      --accent-glow: rgba(107, 140, 255, 0.22);
      --accent2: #c4b5fd;
      --done-color: #3a4268;
      --danger: #f87171;
      --shadow: 0 4px 32px rgba(0,0,0,0.35);
      --shadow-card: 0 2px 16px rgba(0,0,0,0.25);
    }

    /* ==================== RESET & BASE ==================== */
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      font-family: 'Sora', sans-serif;
      background: var(--bg);
      color: var(--text-primary);
      min-height: 100vh;
      display: flex;
      align-items: flex-start;
      justify-content: center;
      padding: 40px 16px 80px;
      transition: background var(--transition), color var(--transition);
      position: relative;
      overflow-x: hidden;
    }

    /* Decorative blobs */
    body::before, body::after {
      content: '';
      position: fixed;
      border-radius: 50%;
      filter: blur(80px);
      opacity: 0.35;
      pointer-events: none;
      z-index: 0;
      transition: opacity var(--transition);
    }
    body::before {
      width: 420px; height: 420px;
      background: radial-gradient(circle, #4f6ef7, #a78bfa);
      top: -100px; right: -100px;
    }
    body::after {
      width: 320px; height: 320px;
      background: radial-gradient(circle, #a78bfa, #60a5fa);
      bottom: -80px; left: -80px;
    }

    /* ==================== APP CONTAINER ==================== */
    .app {
      width: 100%;
      max-width: 560px;
      position: relative;
      z-index: 1;
      animation: fadeUp 0.5s ease both;
    }

    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(28px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    /* ==================== HEADER ==================== */
    .header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 28px;
    }

    .header-left {}

    .app-label {
      font-family: 'Space Mono', monospace;
      font-size: 11px;
      font-weight: 700;
      letter-spacing: 0.2em;
      text-transform: uppercase;
      color: var(--accent);
      margin-bottom: 4px;
    }

    .app-title {
      font-size: clamp(24px, 6vw, 32px);
      font-weight: 700;
      color: var(--text-primary);
      line-height: 1.1;
      letter-spacing: -0.5px;
    }

    .app-title span {
      background: linear-gradient(135deg, var(--accent), var(--accent2));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    /* Dark mode toggle */
    .dark-toggle {
      width: 46px; height: 26px;
      background: var(--surface2);
      border: 2px solid var(--border);
      border-radius: 999px;
      cursor: pointer;
      position: relative;
      transition: background var(--transition), border-color var(--transition);
      flex-shrink: 0;
    }
    .dark-toggle::after {
      content: '';
      position: absolute;
      width: 16px; height: 16px;
      background: var(--accent);
      border-radius: 50%;
      top: 3px; left: 3px;
      transition: transform var(--transition), background var(--transition);
      box-shadow: 0 2px 6px rgba(79,110,247,0.4);
    }
    body.dark .dark-toggle { background: var(--accent-glow); border-color: var(--accent); }
    body.dark .dark-toggle::after { transform: translateX(20px); background: var(--accent2); }
    .toggle-wrap { display: flex; align-items: center; gap: 10px; }
    .toggle-icon { font-size: 18px; user-select: none; }

    /* ==================== STATS BAR ==================== */
    .stats {
      display: flex;
      gap: 10px;
      margin-bottom: 20px;
      flex-wrap: wrap;
    }
    .stat-chip {
      background: var(--surface);
      border: 1.5px solid var(--border);
      border-radius: 999px;
      padding: 6px 16px;
      font-size: 12px;
      font-weight: 600;
      color: var(--text-secondary);
      box-shadow: var(--shadow-card);
      transition: background var(--transition), color var(--transition);
      display: flex; align-items: center; gap: 6px;
    }
    .stat-chip .dot {
      width: 7px; height: 7px;
      border-radius: 50%;
      background: var(--accent);
      display: inline-block;
    }
    .stat-chip.done .dot { background: #34d399; }
    .stat-chip strong { color: var(--text-primary); }

    /* ==================== INPUT CARD ==================== */
    .input-card {
      background: var(--surface);
      border: 1.5px solid var(--border);
      border-radius: var(--radius);
      padding: 18px;
      display: flex;
      gap: 10px;
      margin-bottom: 20px;
      box-shadow: var(--shadow);
      transition: box-shadow var(--transition), background var(--transition);
    }
    .input-card:focus-within {
      box-shadow: 0 0 0 3px var(--accent-glow), var(--shadow);
      border-color: var(--accent);
    }

    #task-input {
      flex: 1;
      border: none;
      outline: none;
      background: transparent;
      font-family: 'Sora', sans-serif;
      font-size: 15px;
      color: var(--text-primary);
      min-width: 0;
    }
    #task-input::placeholder { color: var(--text-secondary); }

    .btn-add {
      background: linear-gradient(135deg, var(--accent), var(--accent2));
      color: #fff;
      border: none;
      border-radius: var(--radius-sm);
      padding: 10px 22px;
      font-family: 'Sora', sans-serif;
      font-size: 14px;
      font-weight: 600;
      cursor: pointer;
      transition: transform 0.15s ease, box-shadow 0.15s ease, filter 0.15s ease;
      white-space: nowrap;
      box-shadow: 0 4px 14px rgba(79,110,247,0.35);
    }
    .btn-add:hover { transform: translateY(-2px); filter: brightness(1.08); box-shadow: 0 6px 20px rgba(79,110,247,0.45); }
    .btn-add:active { transform: translateY(0); }

    /* Error shake */
    .shake { animation: shake 0.35s ease; }
    @keyframes shake {
      0%,100% { transform: translateX(0); }
      20%      { transform: translateX(-8px); }
      60%      { transform: translateX(8px); }
    }

    /* ==================== FILTER TABS ==================== */
    .filters {
      display: flex;
      gap: 6px;
      margin-bottom: 18px;
    }
    .filter-btn {
      background: var(--surface);
      border: 1.5px solid var(--border);
      border-radius: 999px;
      padding: 6px 18px;
      font-family: 'Sora', sans-serif;
      font-size: 13px;
      font-weight: 600;
      color: var(--text-secondary);
      cursor: pointer;
      transition: all var(--transition);
    }
    .filter-btn:hover { border-color: var(--accent); color: var(--accent); }
    .filter-btn.active {
      background: linear-gradient(135deg, var(--accent), var(--accent2));
      color: #fff;
      border-color: transparent;
      box-shadow: 0 3px 12px rgba(79,110,247,0.3);
    }

    /* ==================== TASK LIST ==================== */
    #task-list {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .task-item {
      background: var(--surface);
      border: 1.5px solid var(--border);
      border-radius: var(--radius);
      padding: 16px 18px;
      display: flex;
      align-items: center;
      gap: 14px;
      box-shadow: var(--shadow-card);
      cursor: pointer;
      transition: transform var(--transition), box-shadow var(--transition), border-color var(--transition), background var(--transition), opacity var(--transition);
      animation: slideIn 0.28s cubic-bezier(.4,0,.2,1) both;
    }
    @keyframes slideIn {
      from { opacity: 0; transform: translateY(16px) scale(0.97); }
      to   { opacity: 1; transform: translateY(0) scale(1); }
    }
    .task-item:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow);
      border-color: var(--accent);
    }
    .task-item.done {
      opacity: 0.65;
      border-color: var(--border);
    }
    .task-item.done:hover { border-color: var(--border); transform: none; }

    /* Custom checkbox */
    .task-check {
      width: 22px; height: 22px;
      border-radius: 7px;
      border: 2px solid var(--border);
      flex-shrink: 0;
      display: flex; align-items: center; justify-content: center;
      transition: all var(--transition);
      background: var(--surface2);
    }
    .task-item.done .task-check {
      background: linear-gradient(135deg, #34d399, #10b981);
      border-color: transparent;
    }
    .task-check-icon {
      width: 12px; height: 12px;
      opacity: 0;
      transition: opacity var(--transition), transform var(--transition);
      transform: scale(0.5);
    }
    .task-item.done .task-check-icon { opacity: 1; transform: scale(1); }

    /* Task text */
    .task-text {
      flex: 1;
      font-size: 15px;
      font-weight: 500;
      color: var(--text-primary);
      word-break: break-word;
      transition: color var(--transition);
      position: relative;
    }
    .task-item.done .task-text {
      color: var(--done-color);
      text-decoration: line-through;
      text-decoration-color: var(--done-color);
    }

    /* Delete button */
    .task-delete {
      width: 32px; height: 32px;
      border-radius: 8px;
      border: none;
      background: transparent;
      color: var(--text-secondary);
      font-size: 18px;
      cursor: pointer;
      display: flex; align-items: center; justify-content: center;
      transition: background var(--transition), color var(--transition), transform 0.15s;
      flex-shrink: 0;
      opacity: 0;
    }
    .task-item:hover .task-delete { opacity: 1; }
    .task-delete:hover { background: rgba(248,113,113,0.12); color: var(--danger); transform: scale(1.1); }

    /* ==================== EMPTY STATE ==================== */
    .empty-state {
      text-align: center;
      padding: 48px 24px;
      color: var(--text-secondary);
      display: none;
      animation: fadeUp 0.35s ease;
    }
    .empty-state .empty-icon { font-size: 48px; margin-bottom: 12px; }
    .empty-state p { font-size: 15px; font-weight: 500; }
    .empty-state span { font-size: 13px; opacity: 0.7; }

    /* ==================== CLEAR DONE ==================== */
    .footer {
      margin-top: 18px;
      display: flex;
      justify-content: flex-end;
    }
    .btn-clear {
      background: none;
      border: 1.5px solid var(--border);
      border-radius: 999px;
      padding: 7px 18px;
      font-family: 'Sora', sans-serif;
      font-size: 12px;
      font-weight: 600;
      color: var(--text-secondary);
      cursor: pointer;
      transition: all var(--transition);
    }
    .btn-clear:hover { border-color: var(--danger); color: var(--danger); background: rgba(248,113,113,0.06); }

    /* ==================== RESPONSIVE ==================== */
    @media (max-width: 480px) {
      body { padding: 24px 12px 60px; }
      .input-card { padding: 14px; }
      .btn-add { padding: 10px 14px; font-size: 13px; }
      .task-delete { opacity: 1; }
    }
  </style>
</head>
<body>

  <div class="app">

    <!-- HEADER -->
    <div class="header">
      <div class="header-left">
        <div class="app-label">✦ Quản lý học tập</div>
        <h1 class="app-title">To-do <span>Học Tập</span></h1>
      </div>
      <div class="toggle-wrap">
        <span class="toggle-icon" id="toggle-icon">🌙</span>
        <button class="dark-toggle" id="dark-toggle" aria-label="Bật/tắt dark mode"></button>
      </div>
    </div>

    <!-- STATS -->
    <div class="stats">
      <div class="stat-chip">
        <span class="dot"></span>
        <span id="stat-remaining"><strong>0</strong> còn lại</span>
      </div>
      <div class="stat-chip done">
        <span class="dot"></span>
        <span id="stat-done"><strong>0</strong> hoàn thành</span>
      </div>
    </div>

    <!-- INPUT CARD -->
    <div class="input-card" id="input-card">
      <input
        type="text"
        id="task-input"
        placeholder="Thêm công việc học tập mới..."
        maxlength="120"
        autocomplete="off"
      />
      <button class="btn-add" id="btn-add">+ Thêm</button>
    </div>

    <!-- FILTERS -->
    <div class="filters">
      <button class="filter-btn active" data-filter="all">Tất cả</button>
      <button class="filter-btn" data-filter="todo">Chưa xong</button>
      <button class="filter-btn" data-filter="done">Hoàn thành</button>
    </div>

    <!-- TASK LIST -->
    <div id="task-list" role="list"></div>

    <!-- EMPTY STATE -->
    <div class="empty-state" id="empty-state">
      <div class="empty-icon">📚</div>
      <p>Chưa có công việc nào</p>
      <span>Hãy thêm việc cần làm hôm nay!</span>
    </div>

    <!-- FOOTER -->
    <div class="footer">
      <button class="btn-clear" id="btn-clear">🗑 Xóa đã hoàn thành</button>
    </div>

  </div>

  <script>
    // =============================================
    // STATE & STORAGE
    // =============================================
    let tasks = [];        // Mảng lưu danh sách task
    let currentFilter = 'all'; // Bộ lọc hiện tại

    /** Lưu tasks vào localStorage */
    function saveTasks() {
      localStorage.setItem('hoc-tap-tasks', JSON.stringify(tasks));
    }

    /** Đọc tasks từ localStorage khi tải trang */
    function loadTasks() {
      const raw = localStorage.getItem('hoc-tap-tasks');
      tasks = raw ? JSON.parse(raw) : [];
    }

    /** Lưu trạng thái dark mode */
    function saveDarkMode(isDark) {
      localStorage.setItem('hoc-tap-dark', isDark ? '1' : '0');
    }

    /** Đọc trạng thái dark mode */
    function loadDarkMode() {
      return localStorage.getItem('hoc-tap-dark') === '1';
    }

    // =============================================
    // TASK OPERATIONS
    // =============================================

    /** Tạo task mới */
    function addTask(text) {
      const task = {
        id: Date.now(),       // ID duy nhất dựa theo timestamp
        text: text.trim(),
        done: false,
        createdAt: new Date().toISOString()
      };
      tasks.unshift(task); // Thêm vào đầu mảng
      saveTasks();
      renderTasks();
    }

    /** Đánh dấu hoàn thành / chưa hoàn thành */
    function toggleTask(id) {
      const task = tasks.find(t => t.id === id);
      if (task) {
        task.done = !task.done;
        saveTasks();
        renderTasks();
      }
    }

    /** Xóa một task */
    function deleteTask(id) {
      tasks = tasks.filter(t => t.id !== id);
      saveTasks();
      renderTasks();
    }

    /** Xóa tất cả task đã hoàn thành */
    function clearDoneTasks() {
      tasks = tasks.filter(t => !t.done);
      saveTasks();
      renderTasks();
    }

    // =============================================
    // RENDER
    // =============================================

    /** Lọc tasks theo bộ lọc hiện tại */
    function getFilteredTasks() {
      if (currentFilter === 'todo') return tasks.filter(t => !t.done);
      if (currentFilter === 'done') return tasks.filter(t => t.done);
      return tasks;
    }

    /** Cập nhật thống kê (số còn lại, hoàn thành) */
    function updateStats() {
      const remaining = tasks.filter(t => !t.done).length;
      const done      = tasks.filter(t => t.done).length;
      document.getElementById('stat-remaining').innerHTML =
        `<strong>${remaining}</strong> còn lại`;
      document.getElementById('stat-done').innerHTML =
        `<strong>${done}</strong> hoàn thành`;
    }

    /** Render toàn bộ danh sách task */
    function renderTasks() {
      const list     = document.getElementById('task-list');
      const empty    = document.getElementById('empty-state');
      const filtered = getFilteredTasks();

      updateStats();

      // Hiển thị empty state nếu không có task
      if (filtered.length === 0) {
        list.innerHTML = '';
        empty.style.display = 'block';
        return;
      }
      empty.style.display = 'none';

      // Render từng task
      list.innerHTML = filtered.map(task => `
        <div
          class="task-item ${task.done ? 'done' : ''}"
          data-id="${task.id}"
          role="listitem"
          tabindex="0"
          aria-label="${task.text}${task.done ? ' - đã hoàn thành' : ''}"
        >
          <!-- Checkbox tùy chỉnh -->
          <div class="task-check" title="${task.done ? 'Bỏ hoàn thành' : 'Đánh dấu hoàn thành'}">
            <svg class="task-check-icon" viewBox="0 0 12 12" fill="none" stroke="#fff" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
              <polyline points="1.5,6 4.5,9 10.5,3"/>
            </svg>
          </div>

          <!-- Nội dung task -->
          <span class="task-text">${escapeHtml(task.text)}</span>

          <!-- Nút xóa -->
          <button
            class="task-delete"
            data-id="${task.id}"
            title="Xóa task"
            aria-label="Xóa: ${escapeHtml(task.text)}"
            onclick="event.stopPropagation(); deleteTask(${task.id})"
          >✕</button>
        </div>
      `).join('');

      // Sự kiện click trên task item (toggle)
      list.querySelectorAll('.task-item').forEach(item => {
        item.addEventListener('click', () => {
          const id = Number(item.dataset.id);
          toggleTask(id);
        });
        // Hỗ trợ bàn phím (Enter/Space)
        item.addEventListener('keydown', e => {
          if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            toggleTask(Number(item.dataset.id));
          }
        });
      });
    }

    /** Escape HTML để tránh XSS */
    function escapeHtml(text) {
      const div = document.createElement('div');
      div.appendChild(document.createTextNode(text));
      return div.innerHTML;
    }

    // =============================================
    // EVENT LISTENERS
    // =============================================

    /** Nút Thêm */
    document.getElementById('btn-add').addEventListener('click', () => {
      const input = document.getElementById('task-input');
      const text  = input.value.trim();

      if (!text) {
        // Hiệu ứng shake khi nhập rỗng
        const card = document.getElementById('input-card');
        card.classList.remove('shake');
        void card.offsetWidth; // force reflow
        card.classList.add('shake');
        input.focus();
        return;
      }

      addTask(text);
      input.value = '';
      input.focus();
    });

    /** Nhấn Enter trong input */
    document.getElementById('task-input').addEventListener('keydown', e => {
      if (e.key === 'Enter') {
        document.getElementById('btn-add').click();
      }
    });

    /** Bộ lọc tab */
    document.querySelectorAll('.filter-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        currentFilter = btn.dataset.filter;
        renderTasks();
      });
    });

    /** Xóa task đã hoàn thành */
    document.getElementById('btn-clear').addEventListener('click', () => {
      if (tasks.some(t => t.done)) {
        clearDoneTasks();
      }
    });

    /** Dark mode toggle */
    const darkToggle = document.getElementById('dark-toggle');
    const toggleIcon = document.getElementById('toggle-icon');

    function applyDarkMode(isDark) {
      document.body.classList.toggle('dark', isDark);
      toggleIcon.textContent = isDark ? '☀️' : '🌙';
    }

    darkToggle.addEventListener('click', () => {
      const isDark = !document.body.classList.contains('dark');
      applyDarkMode(isDark);
      saveDarkMode(isDark);
    });

    // =============================================
    // KHỞI ĐỘNG ỨNG DỤNG
    // =============================================
    (function init() {
      loadTasks();
      applyDarkMode(loadDarkMode());
      renderTasks();
    })();
  </script>
</body>
</html>
