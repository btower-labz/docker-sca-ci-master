#!groovy
import hudson.security.*
import jenkins.model.*

final SCA_ADMIN_USR="sca_admin"
final SCA_ADMIN_PWD="passw0rd"

def instance = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
def users = hudsonRealm.getAllUsers()
users_s = users.collect { it.toString() }

// Create the admin user account if it doesn't already exist.
if (SCA_ADMIN_USR in users_s) {
    println "Admin user already exists - updating password"

    def user = hudson.model.User.get(SCA_ADMIN_USR);
    def password = hudson.security.HudsonPrivateSecurityRealm.Details.fromPlainPassword(SCA_ADMIN_PWD)
    user.addProperty(password)
    user.save()
}
else {
    println "--> creating local admin user"

    hudsonRealm.createAccount(SCA_ADMIN_USR, SCA_ADMIN_PWD)
    instance.setSecurityRealm(hudsonRealm)

    def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
    instance.setAuthorizationStrategy(strategy)
    instance.save()
}
