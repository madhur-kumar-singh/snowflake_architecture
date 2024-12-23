CREATE API INTEGRATION IF NOT EXISTS git_integration
    API_PROVIDER = git_https_api
    API_ALLOWED_PREFIXES = ('github.com')
    ALLOWED_AUTHENTICATION_SECRETS = (git_cred)
    ENABLED = true;