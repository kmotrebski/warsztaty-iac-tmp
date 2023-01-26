<?php

function getEnvValue() : string
{
    if (array_key_exists('WARSZTATY_INSTANCE_ID', $_ENV)) {
        return $_ENV['WARSZTATY_INSTANCE_ID'];
    }

    throw new \RuntimeException("Instance environment variable is missing!");
}

$instanceEnvValue = getEnvValue();
$dateFormatted = date('Y-m-d H:i:s');
$version = 'VI';

$html = sprintf(
    "<h1>Aplikacja warsztatowa</h1>Wersja: %s<BR>czas uruchomienia: %s<BR>unikalna zmienna środowiskowa: %s",
    $version,
    $dateFormatted,
    $instanceEnvValue
);

echo $html;
