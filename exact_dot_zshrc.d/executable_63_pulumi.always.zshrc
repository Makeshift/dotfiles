# Naughty, but it's stored in an encrypted S3 bucket, so I don't really care
export PULUMI_CONFIG_PASSPHRASE=''
# https://github.com/pulumi/pulumi/issues/14967
#export PULUMI_EXPERIMENTAL=1
export PULUMI_SKIP_CHECKPOINTS=1
export PULUMI_PARALLEL_DIFF=true
export PULUMI_DIY_BACKEND_GZIP=true
export PULUMI_ERROR_ON_DEPENDENCY_CYCLES=true
export PULUMI_SUPPRESS_COPILOT_LINK=true
