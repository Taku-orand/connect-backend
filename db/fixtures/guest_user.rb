User.seed(:id) do |s|
  s.id = 0
  s.name = "ゲスト"
  s.email = "guest@user.com"
  s.password_digest = "guestuserpassword"
end