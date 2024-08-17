#========================
# Web Site Build Makefile
#========================

css-prereq = ./src/sass/mtsite.sass
# Dart Saas
css-proc   = sass
css-target = ./static/css/mtsite.min.css
public-dir = ./public
s3-bucket  = www.maurotaraborelli.com
site-proc  = hugo --logLevel info

all: site

$(css-target): $(css-prereq)
	@echo -e "Creating minified css file...\t\t\c"
	@$(css-proc) -s compressed $(css-prereq):$(css-target)
	@echo -e "[ Done ]"

site: $(css-target)
	@echo -e "Removing public dir...\t\t\t\c"
	@rm -rf $(public-dir)
	@echo -e "[ Done ]"
	@echo -e "Creating site..."
	@$(site-proc)
	@echo -e "Site created."

deploy: site
	@echo -e "Deploying site to S3...\t\t\c"
	@aws s3 sync public/ s3://$(s3-bucket)/ --profile maurotaraborellisite --acl public-read --storage-class REDUCED_REDUNDANCY --delete
	@echo -e "[Done]"

clean:
	@echo -e "Removing public dir...\t\t\t\c"
	@rm -rf $(public-dir)
	@echo -e "[ Done ]"
	@echo -e "Removing generated css file...\t\t\c"
	@rm -f $(css-target)*
	@echo -e "[ Done ]"
