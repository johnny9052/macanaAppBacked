<?php

class Security {

    public function validarTokenUser($tokenUser) {
        $codeSecurity = "mAcAnAaPp";

        /**         * *************TOKEN DIA ACTUAL********************* */
        $date = date('d/m/Y');
        $token = $this->GenerarToken($codeSecurity . $date);

        /*         * **************TOKEN DIA ANTERIOR********************* */
        $dateYesterday = date('d/m/Y', strtotime("-1 days"));
        $tokenYesterday = $this->GenerarToken($codeSecurity . $dateYesterday);

        /*         * **************TOKEN DIA MAÑANA********************* */
        $dateTomorrow = date('d/m/Y', strtotime("+1 days"));
        $tokenTomorrow = $this->GenerarToken($codeSecurity . $dateTomorrow);

        if ($tokenUser === $token || $tokenUser === $tokenYesterday || $tokenUser === $tokenTomorrow) {
            return true;
        } else {
            return false;
        }
    }

    public function GenerarToken($x) {
        $tokenEncrypted = md5($x);
        return $tokenEncrypted;
    }

}
