//
//  AuthResponse.swift
//  Spotify
//
//  Created by Imran on 9/3/21.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token : String?
    let scope : String
    let token_type: String
}


/*
 {
     "access_token" = "BQAIEAxImTQlzI1-ivSH2x61QI8QcEnf5jSmKztw91xC3RMIdXNQ_mjI-mFUDmIF4j-x4psX__Uo0P5bjru8cp38OP_xK8_0Nv2OBdORs0GlxeoyUmPbGN3QGnCsslJCN-B_JM3uC8nDw46qBOHEaRkMsBIRQ0rHVW2eYn3EuKE9Mjs";
     "expires_in" = 3600;
     "refresh_token" = "AQCR7XFAQNq3gxORB824tBPK0-fRNhsR7w0isfZHVIFwz2zVsMwbU04jKoN3BcfdEt67dbHkCxB_RjYF3EN0bqUy_yC5SeJqrtnAdB89VO5v3EhvB05FtZP11UyRFTeju-Y";
     scope = "user-read-private";
     "token_type" = Bearer;
 }
 
 */
