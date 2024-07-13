package atomicswap

// Swap represents an atomic swap contract.
type Swap struct {
	sender    std.Address
	recipient std.Address
	hashlock  string
	timelock  time.Time
	claimed   bool
	refunded  bool
	amountStr string
	sendFn    func(to std.Address)
}

func newSwap(
	sender std.Address,
	recipient std.Address,
	hashlock string,
	timelock time.Time,
	amountStr string,
	sendFn func(std.Address),
) *Swap {
	require(time.Now().Before(timelock), "timelock must be in the future")
	require(hashlock != "", "hashlock must not be empty")
	return &Swap{
		recipient: recipient,
		sender:    sender,
		hashlock:  hashlock,
		timelock:  timelock,
		claimed:   false,
		refunded:  false,
		sendFn:    sendFn,
		amountStr: amountStr,
	}
}

// Claim allows the recipient to claim the funds if they provide the correct preimage.
func (s *Swap) Claim(preimage string) {
	require(!s.claimed, "already claimed")
	require(!s.refunded, "already refunded")
	require(std.PrevRealm().Addr() == s.recipient, "unauthorized")

	hashlock := sha256.Sum256([]byte(preimage))
	hashlockHex := hex.EncodeToString(hashlock[:])
	require(hashlockHex == s.hashlock, "invalid preimage")

	s.claimed = true
	s.sendFn(s.recipient)
}

// Refund allows the sender to refund the funds after the timelock has expired.
func (s *Swap) Refund() {
	require(!s.claimed, "already claimed")
	require(!s.refunded, "already refunded")
	require(std.PrevRealm().Addr() == s.sender, "unauthorized")
	require(time.Now().After(s.timelock), "timelock not expired")

	s.refunded = true
	s.sendFn(s.sender)
}

func NewCustomCoinSwap(recipient std.Address, hashlock string, timelock time.Time) (int, *Swap) {
	sender := std.PrevRealm().Addr()
	sent := std.GetOrigSend()
	require(len(sent) != 0, "at least one coin needs to be sent")
	sendFn := func(to std.Address) {
		banker := std.GetBanker(std.BankerTypeRealmSend)
		banker.SendCoins(std.GetOrigPkgAddr(), to, sent)
	}
	amountStr := sent.String()
	swap := newSwap(sender, recipient, hashlock, timelock, amountStr, sendFn)
	counter++
	id := strconv.Itoa(counter)
	swaps.Set(id, swap)
	return counter, swap
}

func Claim(id int, secret string) {
	swaps.Get(id).Claim(secret)
}

func Refund(id int) {
	swaps.Get(id).Refund(secret)
}
