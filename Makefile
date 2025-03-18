
codegen:
	dart run build_runner build

test:
	flutter test

setup:
	cp .env.example .env
	codegen
