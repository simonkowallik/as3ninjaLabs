all: artifact

compose:
		cat secrets.yaml tenants/*.yaml mainDefinition.yaml > composed.yaml

declaration: compose
		as3ninja transform --no-validate -c composed.yaml -t template.jinja2 | jq . > AS3Declaration.json

artifact: declaration
		cp -f AS3Declaration.json ~/artifacts/104_AS3Declaration.json

clean:
		rm -f composed.yaml AS3Declaration.json
