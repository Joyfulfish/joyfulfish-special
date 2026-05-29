#!/bin/bash

# 取得腳本所在目錄（網站檔案資料夾）
cd "$(dirname "$0")"

echo "========================================"
echo "  魚樂匯特價網站 - 推送到 GitHub"
echo "========================================"
echo ""

# 檢查是否有變更
if [ -z "$(git status --porcelain)" ]; then
    echo "⚠️  沒有檔案變更，無需推送"
    echo ""
    echo "提示：請先執行 2_生成網站.command 更新網站"
    echo ""
    read -p "按 Enter 鍵關閉視窗..."
    exit 0
fi

# 顯示變更的檔案
echo "📋 以下檔案已變更："
echo "---"
git status --short
echo "---"
echo ""

# 詢問提交訊息
echo "請輸入更新說明（直接按 Enter 使用預設訊息）："
read -p "> " commit_message

# 如果沒有輸入，使用預設訊息
if [ -z "$commit_message" ]; then
    commit_message="更新特價商品資訊 - $(date '+%Y-%m-%d')"
fi

echo ""
echo "📝 提交訊息：$commit_message"
echo ""

# 執行 Git 操作
echo "🔄 正在加入變更..."
git add -A

echo "💾 正在提交變更..."
git commit -m "$commit_message"

echo "📤 正在推送到 GitHub..."
if git push; then
    echo ""
    echo "✅ 成功推送到 GitHub！"
    echo ""
    echo "🌐 網站將在 1-2 分鐘內自動更新"
    echo "    https://joyfulfish.github.io/joyfulfish-special/"
    echo ""
else
    echo ""
    echo "❌ 推送失敗！"
    echo ""
    echo "可能原因："
    echo "1. 網路連線問題"
    echo "2. 需要 GitHub 認證"
    echo "3. 遠端有新的變更需要先拉取"
    echo ""
    echo "建議："
    echo "- 檢查網路連線"
    echo "- 或執行：git pull --rebase 後再試"
    echo ""
fi

read -p "按 Enter 鍵關閉視窗..."
