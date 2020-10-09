# https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html

[[ -x "$(which aws_completer)" ]] && complete -C "$(which aws_completer)" aws
