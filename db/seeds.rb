animal = %w[イヌ
            ネコ
            ウサギ
            パンダ
            ペンギン
            ハムスター
            イルカ
            リス
            コアラ
            キリン
            ゾウ
            カメ
            ラッコ
            ライオン
            ヒツジ
            アルパカ
            シロクマ
            クジラ
            アザラシ
            カンガルー]

hobby = %w[音楽鑑賞
           料理
           筋トレ
           食べ歩き
           スポーツ観戦
           温泉巡り
           映画鑑賞
           カメラ
           ヨガ
           カラオケ
           読書
           旅行
           イラスト
           アニメ鑑賞
           ゲーム
           キャンプ
           サバゲー
           DIY
           家庭菜園
           手芸]

20.times do |_n|
  User.create!(email: Faker::Internet.email,
               password: 'password',
               password_confirmation: 'password',
               confirmed_at: Time.now,
               name: Faker::Games::Pokemon.name,
               sex: rand(0..3),
               birth_date: Date.new(rand(1900..2002), 1, 1),
               animal: animal[rand(0..19)],
               profile: "はじめまして。趣味は#{hobby[rand(0..19)]}です。よろしくお願いします！")
end
