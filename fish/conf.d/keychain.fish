keychain \
	--eval \
	--dir ~/.config/keychain \
	--quiet \
	--noask \
	--agents gpg,ssh id_rsa id_ed25519_github \
	| source
