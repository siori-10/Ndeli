# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.find_or_create_by(
   email: 'admin@gmail.com',
) do |admin|
   admin.password = 'admin123'
end
# 管理者ログインのパスワード
[
  { name: '主菜' },
  { name: '副菜' },
  { name: '汁物' },
  { name: 'デザート'},
  { name: '和食' },
  { name: '洋食' },
  { name: '中華' }
].each do |h|
Tag.find_or_create_by(tag_name: h[:name])
end