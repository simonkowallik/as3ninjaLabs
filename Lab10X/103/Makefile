all: artifact

compose:
		cat secrets.yaml tenants/*.yaml mainDefinition.yaml > composed.yaml

declaration:
		../../cicd/yaml2json -f ./composed.yaml -o - | jq .as3declaration > AS3Declaration.json

artifact: compose declaration
		cp -f AS3Declaration.json ~/artifacts/103_AS3Declaration.json

clean:
		rm -f composed.yaml AS3Declaration.json
