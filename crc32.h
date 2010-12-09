#ifndef VSF_CRC32_H
#define VSF_CRC32_H

/* vsf_crc32_calc()
 * PURPOSE
 * Calculates a CRC32 checksum.
 * PARAMETERS
 * lastcrc    - The checksum calculated by the last call to this function
 * buf        - The data buffer
 * count      - Size of the data buffer in bytes
 * RETURNS
 * An 32 bit checksum.
 */
long vsf_crc32_calc(long lastcrc, const void* buf, int count);

#endif
