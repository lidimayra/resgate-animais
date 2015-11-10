admin = Usuario.create(nome: 'Administrador',
                        data_registro: Date.today,
                        perfil: :administrador,
                        email: 'admin@example.com',
                        password: '12345678',
                        confirmed_at: Time.now)

atendente1 = Usuario.create(nome: Faker::Name.name,
                        data_registro: Date.today,
                        perfil: :atendente,
                        email: 'atendente1@example.com',
                        password: '12345678',
                        confirmed_at: Time.now)

atendente2 = Usuario.create(nome: Faker::Name.name,
                        data_registro: Date.today,
                        perfil: :atendente,
                        email: 'atendente2@example.com',
                        password: '12345678',
                        confirmed_at: Time.now)

atendente3 = Usuario.create(nome: Faker::Name.name,
                        data_registro: Date.today,
                        perfil: :atendente,
                        email: 'atendente3@example.com',
                        password: '12345678',
                        confirmed_at: Time.now)
