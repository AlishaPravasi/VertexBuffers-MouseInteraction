#version 300 es
// Vertex shader

in vec3 vPosition;   // position of vertex (x, y, z)
in vec3 vNormal;     // normal of vertex (x, y, z)
in vec3 vColor;      // color of vertex (r, g, b)

out vec3 fColor;     // output color to send to fragment shader

uniform vec3 lightPosition;        // position of the light source
uniform vec3 diffuseLightColor;    // diffuse light color
uniform vec3 ambientLightColor;    // ambient light color
uniform vec3 specularLightColor;   // specular light color
uniform vec3 mColor;        // material color
uniform float mShiny;           // shininess factor

void main() {
  vec3 viewDirection = -normalize(vPosition);  // view direction

  vec3 lightDirection = normalize(lightPosition - vPosition);  // light direction

  vec3 halfwayVector = normalize(lightDirection + viewDirection);  // halfway vector

  vec3 ambientColor = ambientLightColor * mColor;  // ambient color

  float diffuseFactor = max(dot(normalize(vNormal), lightDirection), 0.0);  // diffuse factor
  vec3 diffuseColor = diffuseLightColor * mColor * diffuseFactor;     // diffuse color

  float specularFactor = pow(max(dot(normalize(vNormal), halfwayVector), 0.0), mShiny);  // specular factor
  vec3 specularColor = specularLightColor * mColor * specularFactor;                 // specular color

  vec3 finalColor = ambientColor + diffuseColor + specularColor;  // final color

  gl_Position = vec4(vPosition, 1.0);  // set vertex position (x, y, z, w)
  gl_PointSize = 20.0;                  // set size of points drawn

  fColor = finalColor;  // pass the final color to the fragment shader
}
