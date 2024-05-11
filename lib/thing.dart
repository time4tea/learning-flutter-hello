

import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties:
    AdditionalProperties(pubName: 'petstore_api', pubAuthor: 'Johnny dep'),
    inputSpecFile: 'swaggers/petstore.yaml',
    generatorName: Generator.dart,
    outputDirectory: 'lib/api/petstore_api')  
class Example {}