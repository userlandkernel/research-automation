# Automation script for downloading XNU directly from Apple
## Usage: Break some X into a halfie sip some soda throwin it up yo throat now show the world you love to rock the boat


# Define y'all where is the tarball
XNU_TAR_PROTOCOL="https"
XNU_TAR_DOMAIN="opensource.apple.com"
XNU_TAR_PATH="tarballs/xnu"
XNU_TAR_URL="$XNU_TAR_PROTOCOL://$XNU_TAR_DOMAIN/$XNU_TAR_PATH"

# Tell me the git to commit
XNU_GIT_SSHUSER="git"
XNU_GIT_DOMAIN="github.com"
XNU_GIT_USER="UKERN-Developers"
XNU_GIT_REPO="darwin-xnu"
XNU_GIT_URL="$XNU_GIT_USER@$XNU_GIT_DOMAIN:$XNU_GIT_USER/$XNU_GIT_REPO.git"

# Get that kernel smoking quickly write it down in one hit
function GetLatestXNU() {
	curl -s "$XNU_TAR_URL/" -o - | grep ".tar.gz" | sed -e 's/.*href=//g' | sed -e 's/>.*//g' | sort -n -u
}

# And the version makes the name
XNU_LATEST_TAR="$(GetLatestXNU)"
XNU_LATEST_VERSION=$(echo "$XNU_LATEST_TAR" | sed -e 's/\.tar\.gz//g')

# Dropin the tarball up our game
echo "Downloading XNU $XNU_LATEST_VERSION..."
curl -s "$XNU_TAR_URL/$XNU_LATEST_TAR" --output "/tmp/$XNU_LATEST_TAR"

# Movin that packs into our lane
tar xvf "/tmp/$XNU_LATEST_TAR"
mv "$XNU_LATEST_VERSION" "/tmp/$XNU_LATEST_VERSION"
cd "/tmp/$XNU_LATEST_VERSION"

# Master of puppets u sellin crap
XNU_MASTERVERSION="$(cat config/MasterVersion | head -n 1)"

# We load kernels up our trap
git clone "git@github.com:UKERN-Developers/darwin-xnu.git" "/tmp/darwin-xnu"

# Update cause the old is wack
cp -r /tmp/$XNU_LATEST_VERSION/* /tmp/darwin-xnu

# Add some molly to the stack
git add .

# Sell it makin Apple mad
git commit -m "Updated xnu to $XNU_LATEST_VERSION ($XNU_MASTERVERSION)"

# Push it ain't no goin back
git push

# And let bash remove our tracks
rm -rf /tmp/darwin-xnu

# All done we got it stashed
echo "Updated xnu to $XNU_LATEST_VERSION ($XNU_MASTERVERSION)"
