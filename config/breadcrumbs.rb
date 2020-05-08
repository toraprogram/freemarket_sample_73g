crumb :root do
  link "トップページ", root_path
end

crumb :mypage do
  link "マイページ", users_path
end

crumb :profiler do
  link "プロフィール", users_path
  parent :mypage
end

crumb :former do
  link "出品ページ", new_item_path
end

crumb :shower do
  link "商品詳細ページ", item_path
end

crumb :editer do
  link "商品編集ページ", edit_item_path
  parent :shower
end

crumb :loginer do
  link "ログインページ", new_user_session_path
end

crumb :newer do
  link "新規登録ページ", new_user_registration_path
end