package inference

import (
	"encoding/binary"
	"math"
	"math/rand"
	"strconv"
)

func ConvertSliceStringToFloat(transactionDataString []string) []float32 {
	res := make([]float32, len(transactionDataString))
	for i := range transactionDataString {
		value, _ := strconv.ParseFloat(transactionDataString[i], 64)
		res[i] = float32(value)
	}
	return res
}

func ConvertByteSliceToFloatSlice(transactionDataString []byte) []float32 {
	total_floats := len(transactionDataString) / 4
	res := make([]float32, total_floats)
	for i := 0; i < total_floats; i++ {
		bits := binary.LittleEndian.Uint32(transactionDataString[i*4 : (i+1)*4])
		res[i] = math.Float32frombits(bits)
	}
	return res
}

func RandReferenceData(n int) []float32 {
	res := make([]float32, n)
	for i := range res {
		res[i] = rand.Float32()
	}
	return res
}

func Uint64frombytes(bytes []byte) uint64 {
	bits := binary.LittleEndian.Uint64(bytes)
	return bits
}

func Float32bytes(float float32) []byte {
	bits := math.Float32bits(float)
	bytes := make([]byte, 4)
	binary.LittleEndian.PutUint32(bytes, bits)
	return bytes
}
