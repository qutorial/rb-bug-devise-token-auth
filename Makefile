install:
	bundle install --without production

migrate:
	rails db:migrate

fix-sqlite-140-problem:
	gem uninstall sqlite3 -v 1.4.0
	make install
