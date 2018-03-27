#!/usr/bin/sh -

gpg --batch --use-agent --decrypt 2>/dev/null <<VAULT_EOF

-----BEGIN PGP MESSAGE-----

hF4Dnh2PDC1Ru2QSAQdA6wYUuhbwqsSjfLddULd4Wv9BFgzB2rw7KCF9t1sPHCUw
ZEN+XxUyc6lH/EV4BBlA2395iXLLB7ugGmkhiGuRnnTFXldN375pmKJG8Ro3fBcE
0mYBfvG+jnSq5zfOcUm0FUzKHXNZsqQu5WUrzTfTAyLVskw8YACcFbKePN3YOMgr
nnDvv5TJKlj6c+mbSQn4ibbx+yVVflYWo5zmBhFthd/ra7y1831AXC0KA2O4Yf/N
3IHHgOYx/R8=
=WTzX

-----END PGP MESSAGE-----

VAULT_EOF

if [ $? -ne 0 ]; then
    echo "Error: Cannot Decrypt Password..." >&2
    echo "__(°~°)__"
fi
