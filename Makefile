####################################################################
#
# Rules used to build and release the SDK.
#
####################################################################

updateVersion:
	sed -i '' -e "3 s/Version .*/Version `cat sdk-version.txt`/g" "./Pod/Classes/SEGLeanplumIntegration.h"
	sed -i '' -e "3 s/Version .*/Version `cat sdk-version.txt`/g" "./Pod/Classes/SEGLeanplumIntegrationFactory.h"

tagCommit:
	git add Pod/Classes/SEGLeanplumIntegration.h; git add Pod/Classes/SEGLeanplumIntegrationFactory.h; git commit -am 'update version'; git tag `cat sdk-version.txt`; git push; git push origin `cat sdk-version.txt`

pushPod: 
	./push.sh;
deploy: updateVersion tagCommit pushPod