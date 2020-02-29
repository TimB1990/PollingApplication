package security;

import java.security.Key;
import java.util.Date;

import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.DatatypeConverter;

// import org.apache.commons.codec.digest.DigestUtils;

import io.jsonwebtoken.*;

public class JWToken {
	
		
	// equavent to issuer = username, subject = password
	public static String issueJWT(String key, String issuer, String subject, long ttlMillis) {
		
		// The JWT signature algorithm to be used to sign the token
		SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;
		
		// set current date
		long nowMillis = System.currentTimeMillis();
		Date now = new Date(nowMillis);
		
		// sign JWT with our ApiKey secret
		byte[] apiKeySecretBytes = DatatypeConverter.parseBase64Binary(key);
		Key signingKey = new SecretKeySpec(apiKeySecretBytes, signatureAlgorithm.getJcaName());
		
		// set JWT payload, claims
		JwtBuilder builder = Jwts.builder()
				.setIssuedAt(now)
				.setSubject(issuer)
				.setIssuer(subject)
				.signWith(signatureAlgorithm, signingKey);
		
		// if specified, add expiration
		if (ttlMillis >= 0) {
			long expMillis = nowMillis + ttlMillis;
			Date exp = new Date(expMillis);
			builder.setExpiration(exp);
		}
		
		// Builds the JWT and serializes it to a compact, URL-safe string
		String token = builder.compact();
		return token;
	}
	
	
	public static boolean validateJWT(HttpServletRequest req, String key) {
		
		// get authorization header
		String authHeader = req.getHeader("Authorization");
		
		// check if authentication header is null or does not start with Bearer
		if (authHeader == null || !authHeader.startsWith("bearer ")) {
			System.out.println("No token provided!");
			return false;
		}

		// retrieve token after Bearer (7 chars inc. space)
		String token = authHeader.substring(7);
		
		// parse claims
		try {
			Claims claims = Jwts.parser()
					.setSigningKey(DatatypeConverter.parseBase64Binary(key))
					.parseClaimsJws(token).getBody();
			
			Date now = new Date(System.currentTimeMillis());
			
			// check if token has expired
			if(now.compareTo(claims.getExpiration()) > 0) {
				System.out.println("The token has been expired!");
				return false;
			}
			
			// when validation is successful
			System.out.println("Token validation successful!");
			return true;
			
		}
		catch(Exception e) {
			
			System.out.println("This token is invalid!");
			return false;
		}
	}
}
